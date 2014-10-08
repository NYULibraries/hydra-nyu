class Nyucore < ActiveFedora::Base
  class Collections
    include Enumerable

    COLLECTION_MAP = {
      'The Real Rosie the Riveter' => ->(nyucore){ nyucore.resource_set == 'rosie_the_riveter' },
      "ESRI" => ->(nyucore){ nyucore.publisher.include? "ESRI" },
      "Spatial Data Repository" => ->(nyucore){ nyucore.type.include? "Geospatial Data" },
      'Asian NGOs Reports' => ->(nyucore){ nyucore.resource_set == 'faculty_digital_archive_ngo' }
    }

    attr_reader :nyucore

    def initialize(nyucore)
      unless nyucore.is_a?(Nyucore)
        raise ArgumentError.new("Expecting an instance of Nyucore, but was #{nyucore.class}")
      end
      @nyucore = nyucore
    end

    # Implement each as collections
    extend Forwardable
    def_delegator :collections, :each

  private

    ##
    # Get array of collections from mapping
    def collections
      @collections ||= COLLECTION_MAP.select do |key,  matcher|
        matcher.call(nyucore)
      end.keys
    end
  end
end
