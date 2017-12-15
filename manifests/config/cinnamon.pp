# linuxmint::config::cinnamon
#
# Configures Linux Mint Cinnamon desktop
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint::config::cinnamon (
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $user)

  # Move the panel to the top of the screen
  gnome::gsettings { 'org.cinnamon_panels-enabled':
    schema => 'org.cinnamon',
    key    => 'panels-enabled',
    value  => '"[\'1:0:top\']"',
    user   => $user,
  }
}
