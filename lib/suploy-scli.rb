require 'fileutils'
require 'tempfile'
require 'json'
require 'gitolite'
require 'sshkey'
require 'docker'


require 'suploy-scli/version.rb'

class Scli
  def initialize(gitolite_dir, git_repo_dir, io=Kernel)
    @gitolite_dir = gitolite_dir
    @stdout = io
    @keydir = "#{gitolite_dir}/keydir"
    @conffile = "#{gitolite_dir}/conf/gitolite.conf"
    @git_repo_dir = git_repo_dir
    @ga_repo = Gitolite::GitoliteAdmin.new(gitolite_dir)
    @gitolite_config = @ga_repo.config
  end

  def add_ssh_key(user, keyname, key_string)
    if SSHKey.valid_ssh_public_key? key_string
        key = Gitolite::SSHKey.from_string(key_string, user, keyname)
        @ga_repo.add_key(key)
        @ga_repo.save_and_apply
    else 
	puts "Not a valid ssh key"
    end 
  end

  def remove_ssh_key(user, keyname)
    key = Gitolite::SSHKey.from_file("#{@keydir}/#{user}@#{keyname}.pub")
    @ga_repo.rm_key(key)
    @ga_repo.save_and_apply
  end

  def add_repository(user, repo)
    repo = Gitolite::Config::Repo.new(repo)
    repo.add_permission("RW+", "", user)
    @gitolite_config.add_repo(repo)
    @ga_repo.save_and_apply
  end

  def remove_repository(repo_name) 
    repo = @gitolite_config.get_repo(repo_name)
    @gitolite_config.rm_repo(repo)
    @ga_repo.save_and_apply
  end

  def view_container(repo) 
    container = Docker::Container.get(repo)
    container.json
  end

  def start_container(repo)
    container = Docker::Container.get(repo)
    result_json = container.start
  end

  def stop_container(repo)
    container = Docker::Container.get(repo)
    container.stop
  end

  # Create a postgres database
  # return the container id, the ip and the ruby database url
  def self.database_create
    container = Docker::Container.create('Image' => 'zumbrunnen/postgresql')
    ret = container.start
    ip = container.json['NetworkSettings']['IPAddress']
    {
      :id => ret.id,
      :ip => ip,
      :connectionString => "postgres://docker:docker@#{ip}/docker"
    }
  end
end
