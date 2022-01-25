# vSphere Homelab Automation

This is a collection of artifacts to recreate my vSphere homelab in an automated way.

Components included:

- [x] VCSA
- [x] ESXi host
- [ ] Shared Storage
- [ ] NSX-T

Tools used:

- Ansible
- Terraform

### VCSA

I'm using two modules as part of the Terraform main.tf file. The first module is to create the A records for the ESXi host, and VCSA. And the second module is to execute the appliance deployment. 

For the appliance, I'm importing the default embedded_vCSA_on_ESXi.json template, and replacing variables with values to create a new answer file, and then calling it as part of the deployment.

Here are the tasks performed by Terraform:

- Create DNS A records for ESXi host, and VCSA
- Execute CLI installer using answer file
- Deploy VCSA

And then Ansible:
- Create DC
- Create Cluster
- Enable EVC
- Create folders
- Create dvSwitch
- Create portgroups
- Configure Teaming, including active/standby uplinks

### ESXi
My lab environment is nested, and while I know there are [several resources](https://williamlam.com/nested-virtualization/nested-esxi-virtual-appliance) available for nested host deployments, I wanted a bit more flexibility. Something that I could apply not only to my lab, but to Production environments as well. This led me to an interesting [blog post](https://thinkingoutcloud.org/2020/03/14/single-touch-esxi-provisioning-with-ansible) which was more of what I am looking to accomplish. I am incorporating his concept of building an ISO on-the-fly. Instead of mounting it to an iLO/DRAC, I'm copying it directly to my physical ESXi host, and mounting it as part of the installer with Terraform.

Here is a quick overview of the execution flow:

1. Ansible builds the ISO, and copies it to the physical ESXi host
2. Ansible executes Terraform
3. Terraform builds the nested ESXi host using the ISO
4. Ansible waits for the host build to complete, and then executes post configuration tasks
   - Join host to vCenter
   - Add host to dvSwitch
   - Migrate Management vmk0 from vSS to vDS
   - Remove vSS
   - Create vmkernel port groups for remaining services (vMotion, vSAN, etc.)
