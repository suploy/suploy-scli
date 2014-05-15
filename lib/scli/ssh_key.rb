module Suploy_scli
  class Scli
    class SSHKey

      def initialize(gitolite_dir)
        @keydir = "#{gitolite_dir}/keydir"
        @ga_repo = Gitolite::GitoliteAdmin.new(gitolite_dir)
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
    end
  end
end
