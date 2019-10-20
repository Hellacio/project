variable "region" {
  default = "europe-north1"
}

variable "project" {
  default = "seaurchins"
}

variable "swarm_managers" {
  default = 1
}

variable "swarm_managers_instance_type" {
  default = "n1-standard-1"
}

variable "zone" {
  default = "europe-north1-a"
}

variable "image_name" {
  default = "ubuntu-os-cloud/ubuntu-1604-lts"
}

variable "ssh_user" {
  default = "ubuntu"
}

variable "swarm_workers" {
  default = 1
}

variable "swarm_workers_instance_type" {
  default = "n1-standard-1"
}