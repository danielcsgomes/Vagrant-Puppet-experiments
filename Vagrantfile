# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :main do |main_config|
    main_config.vm.box = "sedimap"
    #main_config.vm.boot_mode = :gui
    #main_config.vm.box_url = "https://github.com/downloads/Sedimap-pt/sedimap-centos63-x86_64-box/sedimap-centos63-x86_64-base.box"
    main_config.vm.network :hostonly, "192.168.22.22"
    main_config.vm.forward_port 80, 4567
    main_config.vm.customize [
            'modifyvm', :id, '--chipset', 'ich9', # solves kernel panic issue on some host machines
          ]
    main_config.vm.share_folder "v-root", "/vagrant", "."
    main_config.vm.provision :puppet, :module_path => "vagrant/puppet/modules" do |puppet|
      puppet.manifests_path = "vagrant/puppet/manifests"
      puppet.manifest_file = "main.pp"
      puppet.options = [
                '--verbose',
                #'--debug',
              ]
    end
  end
end