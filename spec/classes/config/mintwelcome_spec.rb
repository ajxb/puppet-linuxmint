require 'spec_helper'

describe 'linuxmint::config::mintwelcome' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'configure mintwelcome with defaults' do
        let :params do
          {
            group: 'testgroup',
            user:  'testuser'
          }
        end

        dirs = %w[
          /home/testuser/.linuxmint
          /home/testuser/.linuxmint/mintwelcome
        ]

        dirs.each do |dir|
          it do
            should contain_file(dir).with(
              ensure: 'directory',
              owner:  'testuser',
              group:  'testgroup',
              mode:   '0700'
            )
          end
        end

        it { should contain_file('/home/testuser/.linuxmint/mintwelcome/norun.flag').that_requires('File[/home/testuser/.linuxmint/mintwelcome]') }
        it do
          should contain_file('/home/testuser/.linuxmint/mintwelcome/norun.flag').with(
            ensure: 'file',
            content: '',
            owner:  'testuser',
            group:  'testgroup',
            mode:   '0700'
          )
        end
      end
    end
  end
end
