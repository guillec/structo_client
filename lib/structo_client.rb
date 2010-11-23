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
    resource = create_query(@app_name, modl, @public_key, @private_key, attributes ) 
    post_record resource
  end
  
  def retrieve(modl, id)
    resource = retrieve_query(@app_name, modl, @public_key, @private_key, id)
    get_record resource 
  end
  
  def update(modl, id, attributes)
    resource = update_query(@app_name, modl, @public_key, @private_key, id, attributes)
    post_record resource
  end
  
  def delete(modl, id)
    resource = delete_query(@app_name, modl, @public_key, @private_key, id)
    delete_record resource
  end
  
  def search(modl, attributes = {})
    resource = search_query(@app_name, modl, @public_key, @private_key, attributes)
    get_record resource
  end
  
end
