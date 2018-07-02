resource "google_compute_network" "met-network" {
  name                    = "met-network-${var.met_instance_name}"
  auto_create_subnetworks = true
}

# instance groups?
resource "google_compute_instance" "pe-master" {
  name         = "met-pe-master-${var.met_instance_name}"
  machine_type = "n1-standard-4"
  zone         = "us-east4-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "${google_compute_network.met-network.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    user = "That dude"
  }
}

resource "google_compute_instance" "gitlab" {
  name         = "met-gitlab-${var.met_instance_name}"
  machine_type = "n1-standard-2"
  zone         = "us-east4-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "${google_compute_network.met-network.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    user = "That dude"
  }
}

resource "google_compute_instance" "centos-agent" {
  name         = "met-centos-agent--${var.met_instance_name}-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-east4-a"
  count        = 2

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "${google_compute_network.met-network.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    user = "That dude"
  }
}

resource "google_compute_instance" "ubuntu-agent" {
  name         = "met-ubuntu-agent--${var.met_instance_name}-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-east4-a"
  count        = 2

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "${google_compute_network.met-network.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    user = "That dude"
  }
}
