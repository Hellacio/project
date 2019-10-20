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
    network       = "swarm-network"
    access_config {}
  }
}