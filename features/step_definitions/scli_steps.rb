Given(/^I run the script with add\-ssh \-\-user (.*?) \-\-keyname (.*?) \-\-key "(.*?)"$/) do |user, keyname, ssh_key|
  command = "addssh --user #{user} --keyname #{keyname} --key #{ssh_key}"
  @io = StringIO.new
  @app = Scli.new(command.split(/\s+/), @io)
end

Then(/^the key should be in "(.*?)"\/(.*?)\.pub$/) do |keydir, filename|
  # eventually add test to see if the key in the file is valid
  File.exist?("#{keydir}/#{filename}.pub").should == true
end

Given(/^I run the script with rm\-ssh \-\-user (.*?) \-\-keyname (.*?)$/) do |user, keyname|
  command = "rmssh --user #{user} --keyname #{keyname}"
  @io = StringIO.new
  @app = Scli.new(command.split(/\s+/), @io)
end

Then(/^the key should not be in "(.*?)"\/(.*?)\.pub$/) do |keydir, filename|
  File.exist?("#{keydir}/#{filename}.pub").should == false
end
