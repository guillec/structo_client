require 'rubygems'
require 'structo_connect'
require 'structo_url_gen'
require 'structo_exceptions'

module StructoRecord
  class Base

    def self.create(attributes = {})
      resource = StructoUrlGen.create_query(STRUCTO_APP_NAME, self.to_s, STRUCTO_PUBLIC_KEY, STRUCTO_PRIVATE_KEY, attributes)
      StructoConnect.post_record resource
    end
    
    def self.retrieve(id)
      resource = StructoUrlGen.retrieve_query(STRUCTO_APP_NAME, self.to_s, STRUCTO_PUBLIC_KEY, STRUCTO_PRIVATE_KEY, id)
      StructoConnect.get_record resource
    end 

    def self.update(id, attributes)
      resource = StructoUrlGen.update_query(STRUCTO_APP_NAME, self.to_s, STRUCTO_PUBLIC_KEY, STRUCTO_PRIVATE_KEY, id, attributes)
      StructoConnect.post_record resource
    end
   
    def self.delete(id)
      resource = StructoUrlGen.delete_query(STRUCTO_APP_NAME, self.to_s, STRUCTO_PUBLIC_KEY, STRUCTO_PRIVATE_KEY, id)
      StructoConnect.delete_record resource
    end
   
    def self.search(attributes = {})
      resource = StructoUrlGen.search_query(STRUCTO_APP_NAME, self.to_s, STRUCTO_PUBLIC_KEY, STRUCTO_PRIVATE_KEY, attributes)
      StructoConnect.get_record resource
    end
 
  end
end
