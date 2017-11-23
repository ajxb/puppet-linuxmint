# linuxmint::params
#
# Handles the module default parameters
#
class linuxmint::params {

  case $facts['operatingsystem'] {
    'Ubuntu': {}
    default: {
      fail("${facts['operatingsystem']} not supported")
    }
  }
}
