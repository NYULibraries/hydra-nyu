class SpatialDataRepository < Ichabod::ResourceSet::Base
  self.prefix = 'sdr'
  self.source_reader = :git_geo_blacklight_reader
  self.collection_title = "Spatial Data Repository"
  editor :gis_cataloger

  
  attr_reader :repo_url,:access_token
  alias_method :collection_code, :prefix

  def initialize(*args)
    @repo_url = args.shift || Rails.root.join("ingest/sdr/*json")
    @access_token = args.shift 

    super
  end

end
