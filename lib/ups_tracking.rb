module ParcelTracker
  class UpsTracking
    attr_reader :access_number, :user_id, :password

    def initialize(access_number, user_id, password)
      @access_number = access_number
      @user_id = user_id
      @password = password
    end


    def track(number = nil)
      b = request_access
      b.instruct!
      b.TrackRequest {|b|
        b.Request {|b|
          b.TransactionReference { |b|
						b.CustomerContext 'Rating and Service'
						#b.XpciVersion API_VERSION
					}
					b.RequestOption "15"
					b.RequestAction 'Track'
        }
        b.TrackingNumber number
      }
      respo = get_response "https://wwwcie.ups.com/ups.app/xml/Track"
      p respo.inspect
      respo
    end


    # Goes out, posts the data, and sets the @response variable with the information
		def get_response(url)
			uri            = URI.parse url
			http           = Net::HTTP.new uri.host, uri.port
			if uri.port == 443
				http.use_ssl	= true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			end
			@response_plain = http.post(uri.path, @data).body
			p @response_plain
			return @response_plain.include?('<?xml') ? REXML::Document.new(@response_plain) : @response_plain

			#@response.instance_variable_set "@response_plain", @response_plain
			#def @response.plain; @response_plain; end
		end


    def request_access
			@data = String.new
			b = Builder::XmlMarkup.new :target => @data

			b.instruct!
			b.AccessRequest {|b|
				b.AccessLicenseNumber access_number
				b.UserId user_id
				b.Password password
			}
			return b
		end
  end
end