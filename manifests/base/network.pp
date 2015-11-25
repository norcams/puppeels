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

  # Persistently install dummy module
  if $manage_dummy {
    include ::kmod
    kmod::install { "dummy": }
  }

}
