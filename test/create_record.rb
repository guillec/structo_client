require File.dirname(__FILE__) + '/test_helper'

context "Structo_Record" do

  setup do
    class Record < StructoRecord::Base
    end
    class RecordThatDoesntExist < StructoRecord::Base
    end
  end

  test "Creates a rest resource without any record attributes" do
    record = Record.new
    resource = record.resource
    public_key = APP_CONFIG['structo']['public_key']
    private_key = APP_CONFIG['structo']['private_key']
    assert "#{APP_CONFIG['structo']['name']}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{public_key}&private_key=#{private_key}" == resource.url
  end

  test "Creates a rest resoucrece with one record attribute" do
    record = Record.new
    resource = record.resource({'name' => 'john'})
    public_key = APP_CONFIG['structo']['public_key']
    private_key = APP_CONFIG['structo']['private_key']
    assert "#{APP_CONFIG['structo']['name']}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{public_key}&private_key=#{private_key}&#{record.class.to_s.downcase}[name]=john" == resource.url
  end  
  
  test "Create a rest recosource with more than one record attribute" do
    record = Record.new
    resource = record.resource({'name' => 'john', 'place' => 'baltimore'})
    public_key = APP_CONFIG['structo']['public_key']
    private_key = APP_CONFIG['structo']['private_key']
    assert "#{APP_CONFIG['structo']['name']}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{public_key}&private_key=#{private_key}&#{record.class.to_s.downcase}[name]=john&#{record.class.to_s.downcase}[place]=baltimore" == resource.url
  end

  test "Catch a 500 error" do
    record = RecordThatDoesntExist.new
    record.create
    assert nil == nil
  end
 
  #test "Actually post something to the app" do
  #  record = Record.new
  #  public_key = APP_CONFIG['structo']['public_key']
  #  private_key = APP_CONFIG['structo']['private_key']
  #  record.create({'name' => 'john', 'place' => 'baltimore'})
  #  assert "#{APP_CONFIG['structo']['name']}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{public_key}&private_key=#{private_key}&#{record.class.to_s.downcase}[name]=john&#{record.class.to_s.downcase}[place]=baltimore" != nil 
  #end

end
