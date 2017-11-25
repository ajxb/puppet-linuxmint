# Class: linuxmint
#
# Manage configuration of Linux Mint
#
# @example Declaring the class
#   class { 'linuxmint':
#     user  => 'theuser',
#     group => 'thegroup',
#   }
#
# @param [String] user  Mandatory parameter that specifies the user to configure
# @param [String] group Mandatory parameter that specifies the group for the user param
class linuxmint (
  String $user  = undef,
  String $group = undef,
) inherits linuxmint::params {
  assert_type(String[1], $user)
  assert_type(String[1], $group)

  class { 'linuxmint::config::cinnamon':
    user  => $user,
    group => $group,
  }
  class { 'linuxmint::config::software_centre': }

  contain linuxmint::config::cinnamon
  contain linuxmint::config::software_centre
}
