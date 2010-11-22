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
    resource = record.query('create')
    assert "#{STRUCTO_APP_NAME}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}" == resource.url
  end

  test "Creates a rest resoucrece with one record attribute" do
    record = Record.new
    resource = record.query('create', {'name' => 'john'})
    assert "#{STRUCTO_APP_NAME}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}&#{record.class.to_s.downcase}[name]=john" == resource.url
  end  
  
  test "Create a rest recosource with more than one record attribute" do
    record = Record.new
    resource = record.query('create', {'name' => 'john', 'place' => 'baltimore'})
    assert "#{STRUCTO_APP_NAME}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}&#{record.class.to_s.downcase}[name]=john&#{record.class.to_s.downcase}[place]=baltimore" == resource.url
  end

  test "Catch a 500 error" do
    assert_raise StructoExceptions::InternalServerError do 
     RecordThatDoesntExist.create
    end 
  end
 
  #test "Actually post something to the app" do
  #  record = Record.create
    #record.create({'name' => 'john', 'place' => 'baltimore'})
  #  assert "#{APP_CONFIG['structo']['name']}.structoapp.com/api/#{record.class.to_s.downcase}.json?public_key=#{STRUCTO_PUBLIC_KEY}&private_key=#{STRUCTO_PRIVATE_KEY}&#{record.class.to_s.downcase}[name]=john&#{record.class.to_s.downcase}[place]=baltimore" != nil 
  #end

end
