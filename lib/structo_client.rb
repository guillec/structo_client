require 'rubygems'
require 'structo_url_gen'
require 'structo_connect'

class StructoClient
  include StructoConnect
  include StructoUrlGen
  
  attr_accessor :app_name, :public_key, :private_key
  
  def initialize(app_name, public_key, private_key)
    @app_name=app_name
    @public_key=public_key
    @private_key=private_key
  end
  
  def create(modl, attributes = {})
    resource = StructoUrlGen.create_query(@app_name, modl, @public_key, @private_key, attributes ) 
    StructoConnect.post_record resource
  end
  
  def retrieve(modl, id)
    resource = StructoUrlGen.retrieve_query(@app_name, modl, @public_key, @private_key, id)
    StructoConnect.get_record resource 
  end
  
  def update(modl, id, attributes)
    resource = StructoUrlGen.update_query(@app_name, modl, @public_key, @private_key, id, attributes)
    StructoConnect.post_record resource
  end
  
  def delete(modl, id)
    resource = StructoUrlGen.delete_query(@app_name, modl, @public_key, @private_key, id)
    StructoConnect.delete_record resource
  end
  
  def search(modl, attributes = {})
    resource = StructoUrlGen.search_query(@app_name, modl, @public_key, @private_key, attributes)
    StructoConnect.get_record resource
  end
  
end
