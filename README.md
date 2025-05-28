# Static Site Server

## Project Overview

This project showcases the process of provisioning a basic Linux server on AWS EC2 and configuring it to host a static HTML/CSS website using Nginx. It also includes the implementation of `rsync` for secure and efficient deployment of site updates. 

Designed to build foundational skills, this setup introduces key concepts in web hosting, secure remote access (SSH), file synchronization, and Nginx configuration - critical competencies for Linux system adminstration and DevOps practices. 

> This Project is inspired by [roadmap.sh](https://roadmap.sh/projects/static-site-server)

---

### Requirements
- AWS EC2 Instance (Amazon Linux, `t2.micro` free tier) 
- Nginx Installed and Configured
- A basic HTML/CSS Static Site
- `rsync` Installed Locally
- SSH Key-Based Access to EC2
- (*Optional*) Free Domain Name via [Freenom](https://www.freenom.com/en/index.html?lang=en) or Simliar

---

### Instructions

1. Launch an EC2 Instance and Connect via SSH
> Refer to [SSH Remote Server Setup](https://github.com/TLowest/ssh-remote-server-setup) for specific instructions.

2. Install and Configure Nginx on EC2 Instance
```BASH
sudo yum install nginx -y
```
- Start and enable the service:
```BASH
sudo systemctl start nginx
sudo systemctl enable nginx
```
- Verify the `nginx` user exists on the server
```BASH
ps -ef | grep nginx
```
- If the user exists, you will see an output like:
``` BASH
nginx     1234     1  0 ... nginx: worker process
```
> Note: This is important to verify on the server because it depends entirely on how the `deploy.sh` script handles file ownership and permissions.

3. Build Your Static Website

- On your local machine, create a directory structure:
```BASH
my-website/
├── index.html
├── style.css
└── images/
```

> Note: If you are unfamiliar with [HTML](https://www.w3schools.com/html/default.asp) or [CSS](https://www.w3schools.com/css/default.asp), you can explore introductory resources such as W3Schools for quick, beginner-friendly guidance. 

4. Install `rsync` & Deploy with `deploy.sh` Script

- Ensure `rsync` is properly installed.
```BASH
sudo apt update && sudo apt install rsync -y
```

- Ensure the `deploy.sh` script is executable and then run the script:
```BASH
chmod +x deploy.sh
```
> Note: adjust `KEY_PATH` and `HOST` before use.
```BASH
sudo bash deploy.sh
```




