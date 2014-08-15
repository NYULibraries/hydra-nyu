# We need to bypass VCR in order to load data in the test environment
require 'webmock'
WebMock.allow_net_connect!

namespace :ichabod do

  desc <<-DESC
Read the Resources for a ResourceSet
Usage: rake read['resource_set_name','arg1','arg2',...,'argN'],
where resource_set_name is required and args are optional
  DESC
  task :read, [:name] => :environment do |t, args|
    data_loader = Ichabod::DataLoader.new(args.name, *args.extras)
    data_loader.read.each { |resource| p resource }
  end

  desc  <<-DESC
Load the Nyucores for a ResourceSet into Ichabod
Usage: rake load['resource_set_name','arg1','arg2',...,'argN'],
where resource_set_name is required and args are optional
  DESC
  task :load, [:name] => :environment do |t, args|
    data_loader = Ichabod::DataLoader.new(args.name, *args.extras)
    data_loader.load
  end

  desc  <<-DESC
Delete the Nyucores for a ResourceSet from Ichabod
Usage: rake delete['resource_set_name','arg1','arg2',...,'argN'],
where resource_set_name is required and args are optional
  DESC
  task :delete, [:name] => :environment do |t, args|
    data_loader = Ichabod::DataLoader.new(args.name, *args.extras)
    data_loader.delete
  end
end
