require 'suploy-scli/version.rb'

require 'fileutils'
require 'tempfile'

require 'json'

require 'gitolite'
require 'docker'

class Scli
	def initialize
		@stdout = io
		@keydir = "./"
		@conffile = "./gitolite.conf"
		@git_repo_url = "./"
    @ga_repo = Gitolite::GitoliteAdmin.new("./")
    @gitolite_config = ga_repo.config
	end

	def add_ssh_key(user, keyname, key)
		File.open("#{keydir}/#{user}@#{keyname}.pub", 'w') { |file| file.write(key + "\n") }
		push_git_repo
	end

	def remove_ssh_key(user, keyname)
		File.delete("#{@keydir}/#{user}@#{keyname}.pub")
		push_git_repo
	end

	def add_repository(user, repo)
    repo = Gitolite::Config::Repo.new(repo)
    repo.add_permission(user)
    @gitolite_config.add_repo(repo)
    @ga_repo.save_and_apply
	end

	def remove_repository(repo) 
		tmp = Tempfile.new("extract")

		# we have to keep deleting lines until there is an empty newline
		line_deleted = false

		open("#@conffile", 'r').each do |l|
			if l =~	/^\s*$/ && line_deleted
				line_deleted = false 
				next # don't write the empty newline
			end
			next if line_deleted

			unless l =~ /^repo\s#{repo}$/
				tmp << l 
			else
				line_deleted = true
			end
		end

		tmp.close
		FileUtils.mv(tmp.path, "#@conffile")
    push_git_repo
	end

	def push_git_repo
		# maybe use grit here?
		return
		Dir.chdir(@git_repo_url) do
			system('git add --all')
			system('git commit -m "auto commit"')
			system('git push origin master')
		end
	end

	def view_repository(repo) 
    container = Docker::Container.get(repo)
    container.json
	end

  def start_container(repo)
    container = Docker::Container.get(repo)
    result_json = container.start
    JSON.parse(result_json)
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
