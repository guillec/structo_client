require File.dirname(__FILE__) + '/test_helper'

context "StructoClient" do
  test "It can create a instance of StructoClient" do
    structo_client = StructoClient.new("myapp", "mypublickey", "myprivatekey") 
    another_client = StructoClient.new("apptwo", "11111", "22222")
    assert structo_client.app_name == "myapp"
    assert structo_client.public_key == "mypublickey"
    assert structo_client.private_key == "myprivatekey"
    assert another_client.app_name == "apptwo"
    assert another_client.public_key == "11111"
    assert another_client.private_key == "22222"
  end
  
  test "Throws error message when user doesn't authenticate correctly" do
    structo_client = StructoClient.new("blah", "mypublickey", "myprivatekey")
    assert_raise StructoExceptions::InternalServerError do 
      structo_client.search("Person")
    end 
  end
  

end
