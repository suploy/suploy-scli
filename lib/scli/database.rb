module Scli
  class Database
    def self.database_create
      container = Docker::Container.create('Image' => 'zumbrunnen/postgresql')
      ret = container.start
      ip = container.json['NetworkSettings']['IPAddress']
      {
        :id => ret.id,
        :ip => ip,
        :connection_url => "postgres://docker:docker@#{ip}/docker"
      }
    end
  end
end
