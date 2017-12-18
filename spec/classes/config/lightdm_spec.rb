require 'spec_helper'

describe 'linuxmint::config::lightdm' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure lightdm with defaults' do
        it do
          should contain_file('/etc/lightdm/lightdm.conf').with(
            ensure: 'file',
            source: 'puppet:///modules/linuxmint/lightdm/lightdm.conf',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end

        it do
          should contain_file('/etc/lightdm/slick-greeter.conf').with(
            ensure: 'file',
            source: 'puppet:///modules/linuxmint/lightdm/slick-greeter.conf',
            owner:  'root',
            group:  'root',
            mode:   '0644'
          )
        end
      end
    end
  end
end
