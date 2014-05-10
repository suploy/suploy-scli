## set cucumber timeout to 10 secounds
Before do
  @aruba_timeout_seconds = 10
end

### When Implementations ###

### Def ###

When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end


### SSH Keys ###

When /^I run the "([^"]*)" with ssh add (.*?) (.*?) "([^"]*)"$/ do |app_name , user, keyname, ssh_key|
  @app_name = app_name
  step %(I run `#{app_name} ssh add #{user} #{keyname} "#{ssh_key}" `)
end

When(/^I run the "(.*?)" with ssh rm (.*?) (.*?)$/) do |app_name, user, keyname|
  @app_name = app_name
  step %(I run `#{app_name} ssh rm #{user} #{keyname} `)
end


### Repositorys ###
When /^I get repo add (.*?) (.*?) for "([^"]*)"$/ do |user, repo, app_name|
  @app_name = app_name
  step %(I run `#{app_name} repo add #{user} #{repo} `)
end
 
When(/^I run the "(.*?)" with repo rm (.*?)$/) do |app_name, repo| 
  @app_name = app_name
  step %(I run `#{app_name} repo rm #{repo}`)
end

### Then Implemetations ###

### SSH Keys ###

Then /^the key should be in (.*?)$/ do |filename|
  # eventually add test to see if the key in the file is valid
  File.exist?(filename).should == true
end

Then /^the key should not be in (.*?)$/ do |filename|
  # eventually add test to see if the key in the file is valid
  File.exist?(filename).should == false
end


### Repo Keys ###

Then(/^the \.\/gitolite.conf should contain (.*?) and (.*?)/) do |user,repo|
conf = File.read("/home/vagrant/gitolite-admin/conf/gitolite.conf")
(conf =~ /#{user}/m).should be_true
(conf =~ /#{repo}/m).should be_true
end


Then(/^the \.\/gitolite.conf should not contain (.*?)/) do |repo|
conf = File.read("/home/vagrant/gitolite-admin/conf/gitolite.conf")
(conf =~ /#{repo}/m) == 0
end
