#
class profile::base::network(
  $manage_dummy = false,
) {

  # Set up extra logical fact names for network facts
  include ::named_interfaces

  # example42 network module
  include ::network

  # - Set ifnames=0 and use old ifnames, e.g 'eth0'
  # - Use biosdevname on physical servers, e.g 'em1'
  kernel_parameter { "net.ifnames":
    ensure => present,
    value  => "0",
  }

  # Configure 82599ES SFP+ interface module options
  if $::lspci_has["intel82599sfp"] and "ixgbe" in $::kernel_modules {
    # Set SFP option in /etc/modprobe.d/ixgbe.conf
    include ::kmod
    kmod::option { "allow any SFPs":
      module  => "ixgbe",
      option  => "allow_unsupported_sfp",
      value   => "1",
    }
    # Set option in grub2
    kernel_parameter { "ixgbe.allow_unsupported_sfp":
      ensure => present,
      value  => "1",
    }
  }

  # Persistently install dummy module
  if $manage_dummy {
    include ::kmod
    kmod::install { "dummy": }
  }

}
