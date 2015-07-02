require 'spec_helper'

describe package('rundeck') do
  it { should be_installed }
end

describe service('rundeckd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/rundeck/realm.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /^admin:admin,user,admin$/ }
  its(:content) { should match /^user:passwd,user$/ }
end

describe file('/etc/rundeck/rundeck-config.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /^grails.serverURL = http:\/\/rundeck.local:4440$/ }
  its(:content) { should match /^rundeck.projectsStorageType = filesystem$/ }
end

describe file('/etc/rundeck/project.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /^project.dir = \/home\/rundeck\/projects\/\$\{project\.name\}$/ }
  its(:content) { should match /^project.etc.dir = \/home\/rundeck\/projects\/\$\{project\.name\}\/etc$/ }
  its(:content) { should match /^project.resources.file = \/home\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources\.yml$/ }
end

describe file('/etc/rundeck/jaas-loginmodule.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /RDpropertyfilelogin/ }
  its(:content) { should match /org.eclipse.jetty.plus.jaas.spi.PropertyFileLoginModule required/ }
  its(:content) { should match /debug="true"/ }
  its(:content) { should match /file="\/etc\/rundeck\/realm\.properties"/ }
end
