require 'rubygems'
require 'rest-client'
require 'json'
require 'structo_exceptions'

module StructoRecord
  class Base

    def self.create(attributes = {})
      s = self.new
      url_request = s.query('create', attributes )
      json_object = s.post_record( url_request )
      return JSON.parse(json_object)
    end
    
    def self.retrieve(id)
      s = self.new
      url_request = s.retrieve_query( id ) 
      json_object = s.get_record( url_request )
      return JSON.parse( json_object )
    end 

    def self.update(id, attributes = {})
      s = self.new
      url_request = s.update_query(id, attributes )
      json_object = s.post_record( url_request )
      return JSON.parse( json_object )
    end
   
    def self.delete(id)
     url = "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}/#{id}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}"
     RestClient.delete url
    end
   
    def self.search(attributes = {})
      s = self.new
      url_request = ""
      if attributes != {}
        url_request = s.query('search', attributes )
      else
        url_request = s.query('list')
      end
      json_object = s.get_record( url_request )
      return JSON.parse(json_object)
    end
 
    def update_query( id, attributes )
      q_params = query_params( attributes )
      RestClient::Resource.new "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}/#{id}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}#{q_params}"
    end

    def query(type, attributes = {})
      case type
      when 'create'
        q_params = query_params( attributes )
        return RestClient::Resource.new "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}#{q_params}"
      when 'update'
        q_params = query_params( attributes )
        return RestClient::Resource.new "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}#{q_params}"
      when 'search'
        q_params = search_query_params( attributes )
        return RestClient::Resource.new "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}#{q_params}"
      when 'list'
        q_params = query_params( attributes )
        return RestClient::Resource.new "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}#{q_params}"
      end
    end
    
    def retrieve_query( id )
      RestClient::Resource.new "#{STRUCTO_APP_NAME}.structoapp.com/api/#{self.class.to_s.downcase}/#{id}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}"
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
   
    def get_record(resource)
      response = resource.get { |response, request, result, &block|
        case response.code
        when 200
          response
        when 500
          raise StructoExceptions::InternalServerError
        else
          response.return!(request, result, &block)
        end
      }
    end
 
    def post_record(resource)
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
