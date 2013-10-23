Given(/^I run the script with add\-ssh flopska home "(.*?)"$/) do |ssh_key|
  command = "addssh --user flopska --keyname home --key #{ssh_key}"
  @io = StringIO.new
  @app = Scli.new(command.split(/\s+/), @io)
end

Then(/^the key should be in "(.*?)"flopska@home\.pub$/) do |keydir|
  # eventually add test to see if the key in the file is valid
  File.exist?("#{keydir}/flopska@home.pub").should == true
end

Given(/^I run the script with add\-ssh flopska ubuntu "(.*?)"$/) do |ssh_key|
  pending # express the regexp above with the code you wish you had
end

Then(/^the key should be in "(.*?)"flopska@ubuntu\.pub$/) do |keydir|
  pending # express the regexp above with the code you wish you had
end

Given(/^I run the script with add\-ssh flopska windows "(.*?)"$/) do |ssh_key|
  pending # express the regexp above with the code you wish you had
end

Then(/^the key should be in "(.*?)"flopska@windows\.pub$/) do |keydir|
  pending # express the regexp above with the code you wish you had
end
