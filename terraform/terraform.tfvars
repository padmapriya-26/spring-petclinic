vmn = {
    java_vm = {
        name = "java-vm"
        region = "us-east1"
        zone = "us-east1-b"
        machine_type = "e2-small"
        metadata_startup_script = "java.sh"
    }
    docker_vm = {
        name = "docker-vm"
        region = "us-central1"
        zone = "us-central1-a"
        machine_type = "e2-micro"
        metadata_startup_script = "docker.sh"
    }
}
