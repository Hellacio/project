# data "external" "swarm_tokens" {
#  program = ["./fetch_tokens.sh"]
#  query = {
#    host = "${google_compute_instance.managers.0.network_interface.0.access_config.0.nat_ip}"
#    user = "${var.ssh_user}"
#    private_key = "${file("id_rsa")}"
#  }
#  depends_on = [google_compute_instance.managers]
# }


resource "google_compute_instance" "workers" {
  count        = "${var.swarm_workers}"
  name         = "worker${count.index + 1}"
  machine_type = "${var.swarm_workers_instance_type}"
  zone         = "${var.zone}"

  depends_on = ["google_compute_instance.managers"]

  boot_disk {
    initialize_params {
      image = "${var.image_name}"
      size  = 100
    }
  }

  metadata = {
    sshKeys = "${var.ssh_user}:${file("id_rsa.pub")}"
  }

  network_interface {
    network       = "${google_compute_network.swarm.name}"
    access_config {}
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install apt-transport-https",
      "sudo apt-get -y install ca-certificates",
      "sudo apt-get -y install curl",
      "sudo apt-get -y install gnupg-agent",
      "sudo apt-get -y install software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get -y install jq",
      "sudo apt-get -y install docker-ce",
      "sudo apt-get -y install docker-ce-cli", 
      "sudo apt-get -y install containerd.io",
      "sudo usermod -aG docker ubuntu",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "echo ${google_compute_instance.managers.0.network_interface.0.network_ip}:2377"
 #     "sudo docker swarm join --token ${data.external.swarm_tokens.result.worker} ${google_compute_instance.managers.0.network_interface.0.network_ip}:2377"
    ]
    connection  {
      host = "${google_compute_instance.workers.0.network_interface.0.access_config.0.nat_ip}"
      user = "${var.ssh_user}"
      private_key = "${file("id_rsa")}"
    }
  }
}