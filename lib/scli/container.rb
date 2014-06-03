module Scli
  class Container

    def self.view_container(id_or_name) 
      container = Docker::Container.get(id_or_name)
      container.json
    end

    def self.start_container(repo)
      container = Docker::Container.get(repo)
      result_json = container.start
    end

		# Get the container name from the id
		def self.get_name_from_id(container_id)
			container = Docker::Container.get(container_id)
		end

		# Creates a new docker container from an image
		def self.create_app_container(image_name, environment)
			container = Docker::Container.create('Cmd' => ['/bin/bash', '-c', '/start web'],
															 'Image' => image_name,
															 'Env' => 'PORT=5000',
															 'ExposedPorts' => {
																 "5000/tcp" => {}
															 })
			container.start
		end

		# Creates a new docker container from the image which is connected to the
		# container 'db_container_name'. Use this for database access
		def self.create_app_container_with_db(image_name, environment, db_container_name)
			container = Docker::Container.create('Cmd' => ['/bin/bash', '-c', '/start web'],
															 'Image' => image_name,
															 'Env' => 'PORT=5000',
															 'ExposedPorts' => {
																 "5000/tcp" => {}
															 })
			params = { "Links" => ["#{db_container_name}:db"] }
			container.start(params);
		end

    def self.stop_container(repo)
      container = Docker::Container.get(repo)
      container.stop
    end

    def self.view_all_container()
      Docker::Container.all(:all => true)
    end

  end
end
