provider "google" {
    project = "sinuous-voice-476704-d4"
    region = var.vmn.region
}
resource "google_compute_instance" "vmname" {
    for_each = var.vmn
    name = each.key
    zone = each.value.zone
    machine_type = each.value.machine_type
    boot_disk {
      initialize_params {
        image = "debian-11"
      }
    }
    network_interface {
      network = "default"
      access_config {
        //
      }
    }
    metadata_startup_script = file(each.value.metadata_startup_script)
}

variable "vmn" {
    type = map(object({
        name = string
        region = string
        zone = string
        machine_type = string
        metadata_startup_script = string
    }))
    
}
