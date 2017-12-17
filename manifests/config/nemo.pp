# linuxmint::config::nemo
#
# Configures Linux Mint Nemo
#
# @param [String] user Mandatory parameter that specifies the user to configure
class linuxmint::config::nemo (
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
}
