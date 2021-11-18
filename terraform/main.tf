provider "google" {
  project = "vertical-orbit-324117"
  region  = "asia-east1"
  zone    = "asi-east1-b"
}
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-rule"
  network = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  target_tags = ["allow-http"]
  priority    = 1000

}

resource "google_compute_instance_template" "tpl" {
  name         = "lamptemplate"
  machine_type = "n1-standard-1"
  tags = ["allow-http"]
  disk {
    source_image = "family/lamp"
    auto_delete  = true
    disk_size_gb = 100
    boot         = true
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    foo = "bar"
  }

  can_ip_forward = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "mediawiki-group-manager"
version {
  instance_template  = google_compute_instance_template.tpl.id
}
  base_instance_name = "mediawiki-group-manager"
  zone               = "asia-east1-b"
  target_size        = "1"

}
