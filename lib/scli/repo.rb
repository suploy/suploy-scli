module Scli
  class Repo

    def initialize(gitolite_dir, git_repo_dir)
      @keydir = "#{gitolite_dir}/keydir"
      @git_repo_dir = git_repo_dir
      @ga_repo = Gitolite::GitoliteAdmin.new(gitolite_dir)
      @gitolite_config = @ga_repo.config
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
      FileUtils.rm_rf ("#{@git_repo_dir}/#{repo_name}.git")
    end

    def add_user_to_repository(repo_name, user) 
      repo = @gitolite_config.get_repo(repo_name)
      repo.add_permission("RW+", "", user)
      @ga_repo.save_and_apply
    end

    def remove_user_from_repository(repo_name, user) 
      repo = @gitolite_config.get_repo(repo_name)
      repo.remove_permission("RW+", "", user)
      @ga_repo.save_and_apply
    end
  end
end
