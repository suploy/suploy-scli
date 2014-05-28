module Scli
  class Container

    def view_container(repo) 
      container = Docker::Container.get(repo)
      container.json
    end

    def start_container(repo)
      container = Docker::Container.get(repo)
      result_json = container.start
    end

		# Creates a new docker container from the image which is connected to the
		# container 'db_container_name'. Use this for database access
		def create_app_container_with_db(image_name, environment, db_container_name)
			container = Docker::Container.create('Cmd' => ['/bin/bash', '-c', '/start web'],
															 'Image' => image_name,
															 'Env' => 'PORT=5000',
															 'ExposedPorts' => {
																 "5000/tcp" => {}
															 })
			params = { "Links" => ["#{db_container_name}:db"] }
			container.start(params);
		end

    def stop_container(repo)
      container = Docker::Container.get(repo)
      container.stop
    end

    def view_all_container()
      Docker::Container.all(:all => true)
    end

  end
end
