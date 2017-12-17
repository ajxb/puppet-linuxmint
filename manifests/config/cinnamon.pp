# linuxmint::config::cinnamon
#
# Configures Linux Mint Cinnamon desktop
#
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint::config::cinnamon (
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $user)
}
