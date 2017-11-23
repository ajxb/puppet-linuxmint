# Class: linuxmint
#
# Manage configuration of Linux Mint
#
# @example Declaring the class
#   include linuxmint
#
class linuxmint () inherits linuxmint::params {

  class { 'linuxmint::config::software_centre': }

  contain linuxmint::config::software_centre
}
