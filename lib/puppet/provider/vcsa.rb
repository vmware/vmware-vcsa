# Copyright (C) 2013 VMware, Inc.
require 'pathname' # WORK_AROUND #14073 and #7788
module_lib = Pathname.new(__FILE__).parent.parent.parent
vmware_module = Puppet::Module.find('vmware_lib', Puppet[:environment].to_s)
require File.join vmware_module.path, 'lib/puppet_x/puppetlabs/transport'
require File.join module_lib, 'puppet_x/puppetlabs/transport/ssh'

class Puppet::Provider::Vcsa <  Puppet::Provider
  confine :feature => :ssh

  def self.transport(resource)
    @transport ||= PuppetX::Puppetlabs::Transport.retrieve(:resource_ref => resource[:transport], :catalog => resource.catalog, :provider => 'ssh')
  end

  def transport
    self.class.transport(resource)
  end
end
