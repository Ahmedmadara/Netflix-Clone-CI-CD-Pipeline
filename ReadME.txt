Step 1 — Launch an Ubuntu(22.04) T2 Large Instance

Step 2 — Install Jenkins, Docker and Trivy. Create a Sonarqube Container using Docker.

Step 3 — Create a TMDB API Key.

Step 4 — Install Prometheus and Grafana On the new Server. + node js 

Step 5 — Install the Prometheus Plugin and Integrate it with the Prometheus server.

Step 6 — Email Integration With Jenkins and Plugin setup.

Step 7 — Install Plugins like JDK, Sonarqube Scanner, Nodejs, and OWASP Dependency Check.

Step 8 — Create a Pipeline Project in Jenkins using a Declarative Pipeline

Step 9 — Install OWASP Dependency Check Plugins

Step 10 — Docker Image Build and Push

Step 11 — Deploy the image using Docker

Step 12 — Kubernetes master and slave setup on Ubuntu (20.04)

Step 13 — Access the Netflix app on the Browser.

Step 14 — Terminate the AWS EC2 Instances.

first create 2VMs 1 for jenkins+sonar  and 1 for Prometheus 


Vagrant for creating VMs and ansible for configuration management 
==========================================================
sudo usermod -aG docker ubuntu 
newgrp docker 
docker ps 
sudo chmod 777 /var/run/docker.sock
# give permession to ur user for docker 
=======================================================
go to https://www.themoviedb.org/settings/api        and create a new Api key 


APi key 9d7c084fbfad8cb2aef6335133b5e42d
=======================================================




