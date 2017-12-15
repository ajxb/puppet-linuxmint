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
            group: 'testgroup',
            user:  'testuser'
          }
        end
        it do
          should contain_gnome__gsettings('org.cinnamon_panels-enabled').with(
            schema: 'org.cinnamon',
            key:    'panels-enabled',
            value:  '"[\'1:0:top\']"',
            user:   'testuser'
          )
        end
        it do
          should contain_gnome__gsettings('org.cinnamon_enabled-applets').with(
            schema: 'org.cinnamon',
            key:    'enabled-applets',
            value:  '"[\'panel1:right:1:systray@cinnamon.org:0\', \'panel1:left:0:menu@cinnamon.org:1\', \'panel1:left:1:show-desktop@cinnamon.org:2\', \'panel1:right:3:notifications@cinnamon.org:6\', \'panel1:right:4:removable-drives@cinnamon.org:7\', \'panel1:right:5:user@cinnamon.org:8\', \'panel1:right:6:network@cinnamon.org:9\', \'panel1:right:7:power@cinnamon.org:11\', \'panel1:center:0:calendar@cinnamon.org:12\', \'panel1:right:8:sound@cinnamon.org:13\', \'panel1:right:2:betterlock:17\', \'panel1:right:9:workspace-grid@hernejj:21\']"',
            user:   'testuser'
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
