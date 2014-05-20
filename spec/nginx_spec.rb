require 'spec_helper'
require 'nginx-config'
require 'fileutils'

describe NginxConfig do

  describe '#writeConfig' do
    it 'should add a config file to /etc/nginx/sites-available' do
      NginxConfig.writeConfig("test", "ip80")
      File.exist?("/etc/nginx/sites-available/test").should be_true 
      File.read("/etc/nginx/sites-available/test").should include "test"
      File.read("/etc/nginx/sites-available/test").should include "ip80"
    end

    it 'should add a symlik to /etc/nginx/sites-enabled' do
      NginxConfig.writeConfig("test", "ip80")
      File.symlink?("/etc/nginx/sites-enabled/test").should be_true 
    end

    after(:each) do
      File.delete("/etc/nginx/sites-available/test")
      FileUtils.rm_f("/etc/nginx/sites-enabled/test")
    end

  end
end
