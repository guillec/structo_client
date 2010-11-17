require 'rubygems'
require 'rest-client'
require 'json'
require 'structo_exceptions'

module StructoRecord
  class Base

    def initialize
      @app_name = APP_CONFIG['structo']['name']
      @public_key = APP_CONFIG['structo']['public_key']
      @private_key = APP_CONFIG['structo']['private_key']
    end

    def create(attributes = {})
      url_request = query( attributes )
      json_object = post( url_request )
      return JSON.parse(json_object)
    end
    
    def retreive(id)
      url_request = retrieve_query( id ) 
      json_object = get( url_request )
      return JSON.parse( json_object )
    end 

    def update(id, attributes = {})
      url_request = update_query(id, attributes )
      json_object = post( url_request )
      return JSON.parse( json_object )
    end
   
    def search(attributes = {})
      url_request = ""
      if attributes != {}
        url_request = query('search', attributes )
      else
        url_request = query('list')
      end
      json_object = get( url_request )
      return JSON.parse(json_object)
    end
 
    def update_query( id, attributes )
      q_params = query_params( attributes )
      RestClient::Resource.new "#{@app_name}.structoapp.com/api/#{self.class.to_s.downcase}/#{id}.json?public_key=#{@public_key}&private_key=#{@private_key}#{q_params}"
    end

    def query(type, attributes = {})
      case type
      when 'create'
        q_params = query_params( attributes )
        return RestClient::Resource.new "#{@app_name}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{@public_key}&private_key=#{@private_key}#{q_params}"
      when 'update'
        q_params = query_params( attributes )
        return RestClient::Resource.new "#{@app_name}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{@public_key}&private_key=#{@private_key}#{q_params}"
      when 'search'
        q_params = search_query_params( attributes )
        return RestClient::Resource.new "#{@app_name}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{@public_key}&private_key=#{@private_key}#{q_params}"
      when 'list'
        q_params = query_params( attributes )
        return RestClient::Resource.new "#{@app_name}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{@public_key}&private_key=#{@private_key}#{q_params}"
      end
    end
    
    def retrieve_query( id )
      RestClient::Resource.new "#{@app_name}.structoapp.com/api/#{self.class.to_s.downcase}/#{id}.json?public_key=#{@public_key}&private_key=#{@private_key}"
    end
   
    def search_query_params( attributes ) 
      record_fields = ""
      attributes.each do |key, value|
          record_fields << "&#{key}=#{value}"
      end
      record_fields
    end

    def query_params(attributes) 
      record_fields = ""
      if attributes != {}
        attributes.each do |key, value|
          record_fields << "&#{self.class.to_s.downcase}[#{key}]=#{value}"
        end
      end
      record_fields
    end
   
    def get(resource)
      response = resource.get { |response, request, result, &block|
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
