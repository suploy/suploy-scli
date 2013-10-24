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
  end

  def initialize(argv, io)
    begin
      @options = BIN_SPEC.parse(argv)
    rescue Oyster::HelpRendered; exit
    end

    @stdout = io
    @keydir = "./"
    interpret
  end

  def interpret
    if @options[:addssh]
      user = @options[:addssh][:user]
      keyname = @options[:addssh][:keyname]
      key = @options[:addssh][:key]
      add_ssh_key(user, keyname, @keydir, key)
    end
  end

  def add_ssh_key(user, keyname, keydir, key)
    File.open("#{keydir}/#{user}@#{keyname}.pub", 'w') { |file| file.write(key + "\n") }
  end
end
