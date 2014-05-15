module Scli
  class Database
    def database_create
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
end
