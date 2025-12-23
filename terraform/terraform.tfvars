vmn = {
    java_vm = {
        name = "java-vm"
        zone = "us-east1-b"
        machine_type = "e2-small"
        metadata_startup_script = "Scripts/java.sh"
    }
    docker_vm = {
        name = "docker-vm"
        zone = "us-central1-a"
        machine_type = "e2-micro"
        metadata_startup_script = "Scripts/docker.sh"
    }
}
