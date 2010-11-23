require File.dirname(__FILE__) + '/test_helper'

context "StructoClient" do
  test "It can create a instance of StructoClient" do
    structo_client = StructoClient.new("myapp", "mypublickey", "myprivatekey") 
    assert structo_client.app_name == "myapp"
    assert structo_client.public_key == "mypublickey"
    assert structo_client.private_key == "myprivatekey"
  end
end
