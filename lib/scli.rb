require 'fileutils'
require 'tempfile'
require 'oyster'

class Scli
	BIN_SPEC = Oyster.spec do
		name 'scli -- suploy server command line interface'

		subcommand :addssh do
			name 'scli add'
			string :user, :desc => 'user the key corresponds to'
			string :keyname, :desc => 'name to identify the key'
			string :key, :desc => 'the ssh-key'
		end
		subcommand :rmssh do
			name 'scli rm'
			string :user, :desc => 'user the key corresponds to'
			string :keyname, :desc => 'name to identify the key'
		end
		subcommand :addrepo do
			name 'scli addrepo'
			string :user, :desc => 'user who has repo access'
			string :repo, :desc => 'name of the repository'
		end
		subcommand :rmrepo do
			name 'scli rmrepo'
			string :repo, :desc => 'name of the repository'
		end
	end

	attr_accessor :keydir, :git_repo_url, :conffile

	def initialize(argv, io)
		begin
			@options = BIN_SPEC.parse(argv)
		rescue Oyster::HelpRendered; exit
		end

		@stdout = io
		@keydir = "./"
		@conffile = "./gitolite.conf"
		@git_repo_url = "./"
		interpret
	end

	def interpret
		if @options[:addssh]
			user = @options[:addssh][:user]
			keyname = @options[:addssh][:keyname]
			key = @options[:addssh][:key]
			add_ssh_key(user, keyname, key)
		elsif @options[:rmssh]
			user = @options[:rmssh][:user]
			keyname = @options[:rmssh][:keyname]
			remove_ssh_key(user, keyname)
		elsif @options[:addrepo]
			user = @options[:addrepo][:user]
			repo = @options[:addrepo][:repo]
			add_repository(user, repo)
		elsif @options[:rmrepo]
			repo = @options[:rmrepo][:repo]
			remove_repository(repo)
		end
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
		File.open("#@conffile", 'a') do |file|
			file.write("\nrepo #{repo}")
			file.write("\n    RW+\t=  #{user}\n")
		end
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
end
