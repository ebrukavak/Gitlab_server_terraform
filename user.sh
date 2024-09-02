#!/bin/bash

# Update and install docker packages
sudo yum update -y
sudo yum install -y docker

# Start Docker service
sudo service docker start
sudo usermod -aG docker ec2-user

# Install GitLab Docker image
docker run -d --hostname gitlab.dev-ops.expert -p 443:443 -p 80:80 -p 2222:22 --name gitlab --restart unless-stopped -v /root/gitlab/config:/etc/gitlab -v /root/gitlab/logs:/var/log/gitlab -v /root/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest


# Print completion message
echo "GitLab installation complete. Access it at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"

#get gitlab password
echo "docker exec -it gitlab cat /etc/gitlab/initial_root_password"