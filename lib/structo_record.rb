require 'rubygems'
require 'rest-client'
require 'json'
require 'structo_exceptions'

module StructoRecord
  class Base
    def create(attributes = {})
      res = resource( attributes )
      json_object = post( res )
      return JSON.parse(json_object)
    end
   
    def resource( attributes = {} )
      public_key = APP_CONFIG['structo']['public_key']
      private_key = APP_CONFIG['structo']['private_key']
      record_fields = fields_query(attributes) 
      url = RestClient::Resource.new "#{APP_CONFIG['structo']['name']}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{public_key}&private_key=#{private_key}#{record_fields}"
    end

    def fields_query(attributes) 
      record_fields = ""
      if attributes != {}
        attributes.each do |key, value|
          record_fields << "&#{self.class.to_s.downcase}[#{key}]=#{value}"
        end
      end
      record_fields
    end

    def post(resource)
      response = resource.post("") { |response, request, result, &block|
        case response.code
        when 200
          p "it worked"
          response 
        when 500
          raise StructoExceptions::InternalServerError
        else
          response.return!(request, result, &block)
        end
      }
    end
  end
end
