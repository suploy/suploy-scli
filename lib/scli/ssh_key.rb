module Scli
  # Ugly name but otherwise collision with SSHKey class 
  # from the sshkey gem
  class ScliSSHKey

    def initialize(gitolite_dir)
      @keydir = "#{gitolite_dir}/keydir"
      @ga_repo = Gitolite::GitoliteAdmin.new(gitolite_dir)
    end

    def add_ssh_key(user, keyname, key_string)
      if SSHKey.valid_ssh_public_key? key_string
        key = Gitolite::SSHKey.from_string(key_string, user, keyname)
        @ga_repo.add_key(key)
        @ga_repo.save_and_apply
        return True
      else 
        STDERR.puts "ERROR: Not a valid SSH Key"
        return False
      end 
    end

    def remove_ssh_key(user, keyname)
      key = Gitolite::SSHKey.from_file("#{@keydir}/#{user}@#{keyname}.pub")
      @ga_repo.rm_key(key)
      @ga_repo.save_and_apply
    end
  end
end
