output "jenkins_sonar_ip" {
  value = aws_instance.jenkins_sonar.private_ip
}

output "prometheus_ip" {
  value = aws_instance.prometheus.private_ip
}

output "k8s_master_ip" {
  value = aws_instance.k8s_master.private_ip
}

output "k8s_worker_ip" {
  value = aws_instance.k8s_worker.private_ip
}
