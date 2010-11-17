require File.dirname(__FILE__) + '/test_helper'

context "Structo Record:" do
  setup do 
    @public_key = APP_CONFIG['structo']['public_key']
    @private_key = APP_CONFIG['structo']['private_key']
    @app_name = APP_CONFIG['structo']['name']
    class Record < StructoRecord::Base
    end
  end
  
  test "Creates a good query for retreiving a Record" do
    record = Record.new
    query = record.retrieve_query(1)
    assert "#{@app_name}.structoapp.com/api/#{record.class.to_s.downcase}/1.json?public_key=#{@public_key}&private_key=#{@private_key}" == query.url
  end

  test "Creates a correct url for updating a Record" do
    record = Record.new
    query = record.update_query(1, {'name' => 'bob'})
    assert "#{@app_name}.structoapp.com/api/#{record.class.to_s.downcase}/1.json?public_key=#{@public_key}&private_key=#{@private_key}&#{record.class.to_s.downcase}[name]=bob" == query.url
  end
 
  test "Creates a good query for searching all Records:" do
    record = Record.new
    query = record.query('list')
    assert "#{@app_name}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{@public_key}&private_key=#{@private_key}" == query.url
  end

  test "Create a good query for searching Recods based on attributes" do 
    record = Record.new
    query = record.query('search', {'name' => 'john'})
    assert "#{@app_name}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{@public_key}&private_key=#{@private_key}&name=john" == query.url
  end
end
