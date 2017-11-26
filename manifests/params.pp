# linuxmint::params
#
# Handles the module default parameters
#
class linuxmint::params {
  $group = undef
  $user  = undef

  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
