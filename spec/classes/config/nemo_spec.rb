require 'spec_helper'

describe 'linuxmint::config::nemo' do
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

        schemas = {
          'org.nemo.desktop' => {
            'trash-icon-visible'   => true,
            'network-icon-visible' => true
          }
        }

        schemas.each do |schema, settings|
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
