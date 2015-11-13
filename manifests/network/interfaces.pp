#
class profile::network::interfaces {

  # Set up extra logical fact names for network facts
  include named_interfaces

  # example42 network module
  include network

  # Always set ifnames=0
  # .. and rely on biosdevname for physical servers
  kernel_parameter { "net.ifnames":
    ensure => present,
    value  => "1",
  }

  # Configure 82599ES SFP+ interface module options, if present
  if $::lspci_has["intel82599sfp"] and "ixgbe" in $::kernel_modules {
    # Set SFP option in /etc/modprobe.d/ixgbe.conf
    include kmod
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

}
