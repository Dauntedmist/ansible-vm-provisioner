Vagrant.configure("2") do |config|

    config.vm.define "app-container-01" do |d|
        d.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", auto_correct: true
        d.vm.provider "docker" do |v|
            v.image = "trixie-dev:latest"
            v.name = "app_container_01"
            v.has_ssh = true
            v.privileged = true
        end
    end

    config.vm.define "db-container-01" do |d|
        d.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh", auto_correct: true
        d.vm.provider "docker" do |v|
            v.image = "trixie-dev:latest"
            v.name = "db_container_01"
            v.has_ssh = true
            v.privileged = true
        end
    end

    config.vm.define "logs-container-01" do |d|
        d.vm.network "forwarded_port", guest: 22, host: 2224, id: "ssh", auto_correct: true
        d.vm.provider "docker" do |v|
            v.image = "trixie-dev:latest"
            v.name = "logs_container_01"
            v.has_ssh = true
            v.privileged = true
        end
    end

    config.vm.define "gitlab-container-01" do |d|
        d.vm.network "forwarded_port", guest: 22, host: 2225, id: "ssh", auto_correct: true
        d.vm.provider "docker" do |v|
            v.image = "trixie-dev:latest"
            v.name = "gitlab_container_01"
            v.has_ssh = true
            v.privileged = true
        end
    end

    config.vm.define "langfuse-container-01" do |d|
        d.vm.network "forwarded_port", guest: 22, host: 2226, id: "ssh", auto_correct: true
        d.vm.provider "docker" do |v|
            v.image = "trixie-dev:latest"
            v.name = "langfuse_container_01"
            v.has_ssh = true
            v.privileged = true
        end
    end
end