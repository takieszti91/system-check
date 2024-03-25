Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024*16
    v.cpus = 8
    # I tested AVX support check from other environment.
  end

  # config.vm.box = "ubuntu/trusty64"
end
