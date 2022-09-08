Vagrant.configure("2") do |config|
  config.vm.define :server do |server|
    server.vm.box = "almalinux/8"
    server.vm.hostname = "otus-linux-process-psax"
    server.vm.provision :shell, path: "provision.sh"
  end
end