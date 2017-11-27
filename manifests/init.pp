# Class: linuxmint
#
# Manage configuration of Linux Mint
#
# @example Declaring the class
#   class { 'linuxmint':
#     group => 'thegroup',
#     user  => 'theuser',
#   }
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint (
  String $group = $linuxmint::params::group,
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $group)
  assert_type(String[1], $user)

  class { 'linuxmint::config::cinnamon':
    group => $group,
    user  => $user,
  }
  class { 'linuxmint::config::mintwelcome':
    group => $group,
    user  => $user,
  }
  class { 'linuxmint::config::software_centre':
    user => $user,
  }

  contain linuxmint::config::cinnamon
  contain linuxmint::config::mintwelcome
  contain linuxmint::config::software_centre
}
