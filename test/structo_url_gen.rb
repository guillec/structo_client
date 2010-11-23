require File.dirname(__FILE__) + '/test_helper'

context "StructoUrlGen" do
  test "It can generate a correct CREATE query with NO attributes" do
    resource = StructoUrlGen.create_query "app_name", "Person", "11111", "22222"
    assert resource.url == "app_name.structoapp.com/api/person.json?public_key=11111&private_key=22222"
  end
 
  test "It can generate a correct CREATE query with attributes" do
    resource = StructoUrlGen.create_query "app_name", "Person", "11111", "22222", {"name" => "john"}
    assert resource.url == "app_name.structoapp.com/api/person.json?public_key=11111&private_key=22222&person[name]=john"
  end
 
  test "It can generate a correct RETRIEVE query" do
    resource = StructoUrlGen.retrieve_query "app_name", "Person", "11111", "22222", "1"
    assert resource.url == "app_name.structoapp.com/api/person/1.json?public_key=11111&private_key=22222"
  end 
 
  test "It can generate a correct UPDATE query" do
    resource = StructoUrlGen.update_query "app_name", "Person", "11111", "22222", "1", {"place" => "home"}
    assert resource.url == "app_name.structoapp.com/api/person/1.json?public_key=11111&private_key=22222&person[place]=home"
  end
  
  test "It can generate a correct DELETE query" do
    resource = StructoUrlGen.delete_query "app_name", "Person", "11111", "22222", "1"
    assert resource == "app_name.structoapp.com/api/person/1.json?public_key=11111&private_key=22222"
  end

  test "It can genereate a corret SEARCH query" do
    resource = StructoUrlGen.search_query "app_name", "Person", "11111", "22222", {"name" => "john", "place" => "home"}
    assert resource.url == "app_name.structoapp.com/api/person.json?public_key=11111&private_key=22222&name=john&place=home"
  end
  
  test "It can generate a correct LIST query" do
    resource = StructoUrlGen.search_query "app_name", "Person", "11111", "22222"
    assert resource.url == "app_name.structoapp.com/api/person.json?public_key=11111&private_key=22222"
  end
  
end
