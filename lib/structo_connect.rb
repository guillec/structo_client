require 'rubygems'
require 'rest-client'
require 'json'
require 'structo_exceptions'

module StructoConnect

  def self.post_record(resource)
    response = resource.post("") { |response, request, result, &block|
      case response.code
      when 200
        JSON.parse(response)
      when 500
        raise StructoExceptions::InternalServerError
      else
        response.return!(request, result, &block)
      end
     }
   end

   def self.get_record(resource)
     response = resource.get { |response, request, result, &block|
       case response.code
       when 200
         JSON.parse(response)
       when 500
         raise StructoExceptions::InternalServerError
       else
         response.return!(request, result, &block)
       end
     }
   end
  
   def self.delete_record(resource)
     RestClient.delete resource
   end
end
