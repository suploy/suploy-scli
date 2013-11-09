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
  end

	attr_accessor :keydir, :git_repo_url

  def initialize(argv, io)
    begin
      @options = BIN_SPEC.parse(argv)
    rescue Oyster::HelpRendered; exit
    end

    @stdout = io
    @keydir = "./"
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

	def push_git_repo
		# maybe use grit here?
		Dir.chdir(@git_repo_url) do
			system('git add .')
			system('git commit -m "auto commit"')
			system('git push origin master')
		end
	end
end
