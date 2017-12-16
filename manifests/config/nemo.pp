# linuxmint::config::nemo
#
# Configures Linux Mint Nemo
#
# @param [String] user Mandatory parameter that specifies the user to configure
class linuxmint::config::nemo (
  String $user  = $linuxmint::params::user,
) inherits linuxmint::params {
  $schemas = {
    'org.nemo.desktop' => {
      'trash-icon-visible'   => true,
      'network-icon-visible' => true,
    },
  }

  $schemas.each |$schema, $settings| {
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
