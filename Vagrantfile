Vagrant.configure("2") do |config|
  # Jenkins-SonarQube VM
  config.vm.define "jenkins-sonar" do |jenkins_sonar|
      jenkins_sonar.vm.box = "ubuntu/focal64"
      jenkins_sonar.vm.hostname = "jenkins-sonar"
      jenkins_sonar.vm.network "private_network", ip: "192.168.30.20"
      jenkins_sonar.vm.provider "virtualbox" do |vb|
          vb.memory = "4096"
          vb.cpus = 2
      end
      jenkins_sonar.vm.provision "ansible_local" do |ansible|
          ansible.playbook = "provisioning/jenkins-sonar.yml"
      end
  end

  # Prometheus VM
  config.vm.define "prometheus" do |prometheus|
      prometheus.vm.box = "ubuntu/focal64"
      prometheus.vm.hostname = "prometheus"
      prometheus.vm.network "private_network", ip: "192.168.30.21"
      prometheus.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
          vb.cpus = 2
      end
      prometheus.vm.provision "ansible_local" do |ansible|
          ansible.playbook = "provisioning/prometheus.yml"
      end
  end

  # Kubernetes Master Node
  config.vm.define "k8s-master" do |k8s_master|
      k8s_master.vm.box = "ubuntu/focal64"
      k8s_master.vm.hostname = "k8s-master"
      k8s_master.vm.network "private_network", ip: "192.168.30.22"
      k8s_master.vm.provider "virtualbox" do |vb|
          vb.memory = "4096"
          vb.cpus = 2
      end
      # No Ansible provisioning
  end

  # Kubernetes Worker Node
  config.vm.define "k8s-worker" do |k8s_worker|
      k8s_worker.vm.box = "ubuntu/focal64"
      k8s_worker.vm.hostname = "k8s-worker"
      k8s_worker.vm.network "private_network", ip: "192.168.30.23"
      k8s_worker.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
          vb.cpus = 2
      end
      # No Ansible provisioning
  end
end
