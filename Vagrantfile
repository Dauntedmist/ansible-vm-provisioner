Vagrant.configure("2") do |config|

    config.vm.define "app-container-01" do |d|
        d.vm.provider "docker" do |v|
            v.image = "trixie-dev:latest"
            v.name = "app_container_01"
            v.has_ssh = true
            v.privileged = true # Needed if Ansible is managing services/systemd
        end
    end
end