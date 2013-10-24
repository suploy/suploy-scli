Given(/^I run the script with add\-ssh \-\-user flopska \-\-keyname home \-\-key "(.*?)"$/) do |ssh_key|
  command = "addssh --user flopska --keyname home --key #{ssh_key}"
  @io = StringIO.new
  @app = Scli.new(command.split(/\s+/), @io)
end

Then(/^the key should be in "(.*?)"\/flopska@home\.pub$/) do |keydir|
  # eventually add test to see if the key in the file is valid
  File.exist?("#{keydir}/flopska@home.pub").should == true
end

Given(/^I run the script with add\-ssh \-\-user flopska \-\-keyname ubuntu \-\-key "(.*?)"$/) do |ssh_key|
  command = "addssh --user flopska --keyname ubuntu --key #{ssh_key}"
  @io = StringIO.new
  @app = Scli.new(command.split(/\s+/), @io)
end

Then(/^the key should be in "(.*?)"\/flopska@ubuntu\.pub$/) do |keydir|
  # eventually add test to see if the key in the file is valid
  File.exist?("#{keydir}/flopska@ubuntu.pub").should == true
end

Given(/^I run the script with add\-ssh \-\-user flopska \-\-keyname windows \-\-key "(.*?)"$/) do |ssh_key|
  command = "addssh --user flopska --keyname windows --key #{ssh_key}"
  @io = StringIO.new
  @app = Scli.new(command.split(/\s+/), @io)
end

Then(/^the key should be in "(.*?)"\/flopska@windows\.pub$/) do |keydir|
  # eventually add test to see if the key in the file is valid
  File.exist?("#{keydir}/flopska@windows.pub").should == true
end
