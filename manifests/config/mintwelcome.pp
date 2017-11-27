# linuxmint::config::mintwelcome
#
# Configures Linux Mint Mint Welcome tool
#
# @param [String] group Mandatory parameter that specifies the group for the user param
# @param [String] user  Mandatory parameter that specifies the user to configure
class linuxmint::config::mintwelcome (
  String $group = $linuxmint::params::group,
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  assert_type(String[1], $user)
  assert_type(String[1], $group)

  $dirs = [
    "/home/${user}/.linuxmint",
    "/home/${user}/.linuxmint/mintwelcome",
   ]

  file { $dirs:
    ensure => 'directory',
    owner  => $user,
    group  => $group,
    mode   => '0700',
  }

  file { "/home/${user}/.linuxmint/mintwelcome/norun.flag":
    ensure  => 'file',
    content => '',
    owner   => $user,
    group   => $group,
    mode    => '0700',
    require => [
      File["/home/${user}/.linuxmint/mintwelcome"],
    ],
  }
}
