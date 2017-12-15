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
      end
      context 'user param not set' do
        it do
          expect do
            subject.call
          end.to raise_error(Puppet::PreformattedError, /parameter 'user' expects a String value, got Undef/)
        end
      end
    end
  end
end
