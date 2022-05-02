# CyberBootcamp
Homework13/Project1
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: Update the path with the name of your diagram](Images/diagram_filename.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the install-elk.yml file may be used to install only certain pieces of it, such as Filebeat.

  ---
- name: Installing and Launch Filebeat
  hosts: webservers
  become: yes
  tasks:
    # Use command module
  - name: Download filebeat .deb file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb

 # Use command module
  - name: Install filebeat .deb
    command: dpkg -i filebeat-7.4.0-amd64.deb

    # Use copy module
  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

    # Use command module
  - name: Enable and Configure System Module
    command: filebeat modules enable system

    # Use command module
  - name: Setup filebeat
    command: filebeat setup
    # Use command module
  - name: Start filebeat service
    command: service filebeat start

    # Use systemd module
  - name: Enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes


This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly REDUNDANT, in addition to restricting ACCESS to the network.
What aspect of security do load balancers protect? Load balancers increase capacity and reliability. They improve performance and availability.
What is the advantage of a jump box?_It is the only server in the network with a public IP address. All the other network servers can only be accessed, via their private IP addresses, from the jumpbox. This provides excellent security for the Elk Stack server and the other 2 web servers in the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the configuration files and system logs.
What does Filebeat watch for?_Filebeat monitors log files, collects log events, and forwards them to either Elasticsearch or Logstash for indexing.
What does Metricbeat record?_metrics and statistics from the system and services running on the server, such as Apache.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name 	| Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.1   | Linux        	|
| WEB 1	|LAMP Server|10.0.0.10  | Linux            	|
| WEB 2	|LAMP Server |10.0.0.11  | Linux           	|
| ELKServer|Security  |10.1.0.4  |  Linux             |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
Add whitelisted IP addresses_108.44.246.248

Machines within the network can only be accessed by ssh from the Jumpbox using the RedAdmin Security group.
Which machine did you allow to access your ELK VM? What was its IP address? The Jumpbox. Public IP 20.126.95.226

A summary of the access policies in place can be found in the table below.

| Name 	| Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes		          	| 10.0.0.10 10.0.0.11 10.1.0.4	|
| ElkServer |No                 	|20.126.95.226               	|
| Web 1, Web 2| 	 No             |20.126.95.226             	|

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
What is the main advantage of automating configuration with Ansible?_Can easily add servers to the network by using the same ansible file. Can make changes to existing servers easily by modifying the ansible yaml file.

The playbook implements the following tasks:
In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Install Docker module
- Install Python
- Increase virtual memory
- Launch the Docker ELK container
- Identify ports that ELK runs on
- Tell the ELK server to start at boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
List the IP addresses of the machines you are monitoring 10.0.0.10 and 10.0.0.11
We have installed the following Beats on these machines:
Specify which Beats you successfully installed Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:

Filebeat collects syslog hostnames and processes such as ssh log-ins
Metricbeat shows memory usage, cpu usage, network io

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the Install-Elk.yml file to /etc/ansible.
- Update the Install-ELK.yml file to include...increase virtual memory
- Run the playbook, and navigate to ELK SERVER to check that the installation worked as expected.

Answer the following questions to fill in the blanks:_
- Which file is the playbook? Install-ELK.yml Where do you copy it? /etc/ansible/
- _Which file do you update to make Ansible run the playbook on a specific machine? Ansbile.cfg How do I specify which machine to install the ELK server on versus which to install Filebeat on? Update the hosts file
- _Which URL do you navigate to in order to check that the ELK server is running? http://20.203.194.16:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.
Ansible-playbook install-ELK.yml
Ansible-playbook filebeat-playbook.yml
Ansible-playbook metricbeat-playbook.yml
Ansible -m ping all

