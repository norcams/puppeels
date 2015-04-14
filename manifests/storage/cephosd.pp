# Class: profile::storage::cephmon
#
#
class profile::storage::cephmon(
  $manage_firewall = false,
  $firewall_extras = {
    'mon_listen'   => {},
  },
) {

#  include ::ceph::profile::mon

  if $manage_firewall {
    profile::firewall::rule { '100 ceph-mon accept tcp':
      port   => 6789,
      extras => $firewall_extras['mon_listen']
    }
  }
}
