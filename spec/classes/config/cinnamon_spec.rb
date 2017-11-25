require 'spec_helper'

describe 'linuxmint::config::cinnamon' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure cinnamon with defaults' do
        let :params do
          {
            user: 'testuser',
            group: 'testgroup'
          }
        end
        it { should contain_package('dconf-tools').with_ensure('latest') }
        it do
          should contain_gnome__gsettings('org.cinnamon_panels-enabled').with(
            schema: 'org.cinnamon',
            key:    'panels-enabled',
            value:  '[\'1:0:top\']'
          )
        end
        it do
          should contain_gnome__gsettings('org.cinnamon_enabled-applets').with(
            schema: 'org.cinnamon',
            key:    'enabled-applets',
            value:  '[\'panel1:right:0:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:left:2:panel-launchers@cinnamon.org:3\', \'panel1:left:3:window-list@cinnamon.org:4\', \'panel1:right:1:keyboard@cinnamon.org:5\', \'panel1:right:2:notifications@cinnamon.org:6\', \'panel1:right:3:removable-drives@cinnamon.org:7\', \'panel1:right:4:user@cinnamon.org:8\', \'panel1:right:5:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:9:sound@cinnamon.org:13\']'
          )
        end
        it { should contain_exec('dbus-launch dconf reset -f /org/cinnamon/').that_subscribes_to('Gnome::Gsettings[org.cinnamon_enabled-applets]') }
        it { should contain_exec('dbus-launch dconf reset -f /org/cinnamon/').that_requires('Package[dconf-tools]') }
        it do
          should contain_exec('dbus-launch dconf reset -f /org/cinnamon/').with(
            command: '/usr/bin/dbus-launch /usr/bin/dconf reset -f /org/cinnamon/',
            user:    'testuser'
          )
        end
        it do
          should contain_file('/home/testuser/.cinnamon/configs/calendar@cinnamon.org/12.json').with(
            ensure: 'file',
            source: 'puppet:///modules/linuxmint/cinnamon/calendar@cinnamon.org/12.json',
            owner:  'testuser',
            group:  'testgroup',
            mode:   '0664'
          )
        end
      end
      context 'user param not set' do
        let :params do
          {
            group: 'testgroup'
          }
        end
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end
      context 'group param not set' do
        let :params do
          {
            user: 'testuser'
          }
        end
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'group' expects a String value, got Undef/)
        end
      end
    end
  end
end
