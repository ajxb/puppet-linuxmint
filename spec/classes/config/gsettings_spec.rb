require 'spec_helper'

describe 'linuxmint::config::gsettings' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure nemo with defaults' do
        let :params do
          {
            user: 'testuser'
          }
        end

        gsettings = {
          'com.linuxmint.updates' => {
            'kernel-updates-are-safe'      => false,
            'kernel-updates-are-visible'   => true,
            'level1-is-safe'               => true,
            'level1-is-visible'            => true,
            'level2-is-safe'               => true,
            'level2-is-visible'            => true,
            'level3-is-safe'               => false,
            'level3-is-visible'            => true,
            'level4-is-safe'               => false,
            'level4-is-visible'            => true,
            'level5-is-safe'               => false,
            'level5-is-visible'            => false,
            'security-updates-are-safe'    => true,
            'security-updates-are-visible' => true,
            'show-policy-configuration'    => false
          },
          'org.cinnamon' => {
            'enabled-applets' => '"[\'panel1:right:1:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:right:3:notifications@cinnamon.org:6\', \'panel1:right:4:removable-drives@cinnamon.org:7\', \'panel1:right:5:user@cinnamon.org:8\', \'panel1:right:6:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:8:sound@cinnamon.org:13\', \'panel1:right:2:betterlock:17\', \'panel1:right:9:workspace-grid@hernejj:21\']"',
            'panels-enabled'  => '"[\'1:0:top\']"'
          },
          'org.nemo.desktop' => {
            'trash-icon-visible'   => true,
            'network-icon-visible' => true
          }
        }

        gsettings.each do |schema, settings|
          settings.each do |key, value|
            it do
              should contain_gnome__gsettings("#{schema}_#{key}").with(
                schema: schema,
                key:    key,
                value:  value,
                user:   'testuser'
              )
            end
          end
        end
      end
    end
  end
end
