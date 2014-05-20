
class NginxConfig 

  def self.writeConfig(repo_name, ip) 

    sites_available_file_str = "/etc/nginx/sites-available/#{repo_name}"
    sites_enabled_file_str = "/etc/nginx/sites-enabled/#{repo_name}"

    begin
      file = File.new(sites_available_file_str, "w+")
      file.write "upstream app_server {\n"
      file.write "    server #{ip} fail_timeout=0;\n"
      file.write "}\n"
      file.write "server {\n"
      file.write "    listen 80;\n"
      file.write "    server_name #{repo_name}.example.com;\n"
      file.write "    location / {\n"
      file.write "        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n"
      file.write "        proxy_set_header Host $http_host;\n"
      file.write "        proxy_redirect off;\n"
      file.write "        if (!-f $request_filename) {\n"
      file.write "            proxy_pass http://app_server_test;\n"
      file.write "            break;\n"
      file.write "        }\n"
      file.write "     }\n"
      file.write "}\n"

      File.symlink(sites_available_file_str, sites_enabled_file_str)
      %x( sudo /etc/init.d/nginx reload )
    rescue IOError => e
      #TODO: add exception handling
    ensure
      file.close unless file == nil
    end

  end
end
    
