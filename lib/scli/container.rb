module Suploy_scli
  class Scli
    class Container

      def view_container(repo) 
        container = Docker::Container.get(repo)
        container.json
      end

      def start_container(repo)
        container = Docker::Container.get(repo)
        result_json = container.start
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
end
