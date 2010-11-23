require 'rest-client'

module StructoUrlGen
  def self.create_query(app_name, modl, public_key, private_key, attributes = {} )
    p_params = post_params(modl, attributes)
    return RestClient::Resource.new "#{app_name}.structoapp.com/api/#{modl.downcase}.json?public_key=#{public_key}&private_key=#{private_key}#{p_params}" 
  end 
  
  def self.retrieve_query(app_name, modl, public_key, private_key, id)
    RestClient::Resource.new "#{app_name}.structoapp.com/api/#{modl.downcase}/#{id}.json?public_key=#{public_key}&private_key=#{private_key}"
  end
  
  def self.update_query(app_name, modl, public_key, private_key, id, attributes)
    p_params = post_params( modl, attributes)
    return RestClient::Resource.new "#{app_name}.structoapp.com/api/#{modl.downcase}/#{id}.json?public_key=#{public_key}&private_key=#{private_key}#{p_params}"
  end

  def self.delete_query(app_name, modl, public_key, private_key, id)
   "#{app_name}.structoapp.com/api/#{modl.downcase}/#{id}.json?public_key=#{public_key}&private_key=#{private_key}"
  end

  def self.search_query(app_name, modl, public_key, private_key, attributes = {})
    if attributes != {}
      q_params = search_params( attributes )
      return RestClient::Resource.new "#{app_name}.structoapp.com/api/#{modl.downcase}.json?public_key=#{public_key}&private_key=#{private_key}#{q_params}"
    else
      return RestClient::Resource.new "#{app_name}.structoapp.com/api/#{modl.downcase}.json?public_key=#{public_key}&private_key=#{private_key}"
    end
  end

  def self.search_params( attributes )
    record_fields = ""
    attributes.each do |key, value|
        record_fields << "&#{key}=#{value}"
    end
    record_fields
  end
  
  def self.post_params(modl, attributes)
    record_fields = ""
    if attributes != {}
      attributes.each do |key, value|
        record_fields << "&#{modl.downcase}[#{key}]=#{value}"
      end
    end
    record_fields
  end

end
