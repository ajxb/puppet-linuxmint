# linuxmint::params
#
# Handles the module default parameters
#
class linuxmint::params {
  $group = undef
  $user  = undef
  $packages_root = '/opt/packages_puppet-linuxmint'

  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
