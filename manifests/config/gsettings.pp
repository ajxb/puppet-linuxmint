# linuxmint::config::gsettings
#
# Configures gsettings for specified user
#
# @param [String] user Mandatory parameter that specifies the user to configure
class linuxmint::config::gsettings (
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  $linuxmint::params::gsettings.each |$schema, $settings| {
    $settings.each |$key, $value| {
      gnome::gsettings { "${schema}_${key}":
        schema => $schema,
        key    => $key,
        value  => $value,
        user   => $user,
      }
    }
  }
}
