class Nyucore < ActiveFedora::Base
  class Collections
    include Enumerable

    COLLECTION_MAP = {
      'The Real Rosie the Riveter' => ->(nyucore){ nyucore.resource_set == 'rosie_the_riveter' },
      'Voices of the Food Revolution' => ->(nyucore){ nyucore.resource_set == 'voice' },
      'Research Guides' => ->(nyucore){ nyucore.resource_set == 'lib_guides' },
      "Spatial Data Repository" => ->(nyucore){ nyucore.type.include? "Geospatial Data" },
      "Archive of Contemporary Composers' Websites" => ->(nyucore){ nyucore.resource_set == 'archive_it_accw' },
      'South Asian NGO and other reports' => ->(nyucore){ nyucore.resource_set == 'faculty_digital_archive_ngo'},
      'NYU Press Open Access Books' => ->(nyucore){ nyucore.resource_set == 'nyu_press_open_access_book' },
      'Data Services' => ->(nyucore){ nyucore.resource_set == 'faculty_digital_archive_service_data' },
      'The Masses' => ->(nyucore){ nyucore.resource_set == 'masses' }
      'Indian Ocean Postcards' => ->(nyucore){ nyucore.resource_set == 'indian_ocean_data' }
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
