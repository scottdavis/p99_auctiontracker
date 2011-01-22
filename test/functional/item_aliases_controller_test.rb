require 'test_helper'

class ItemAliasesControllerTest < ActionController::TestCase
  setup do
    @item_alias = Factory(:item_alias, :item => Factory(:item))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_aliases)
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  # 
  # test "should create item_alias" do
  #   assert_difference('ItemAlias.count') do
  #     post :create, :item_alias => @item_alias.attributes
  #   end
  # 
  #   assert_redirected_to item_alias_path(assigns(:item_alias))
  # end
  # 
  # test "should show item_alias" do
  #   get :show, :id => @item_alias.to_param
  #   assert_response :success
  # end
  # 
  # test "should get edit" do
  #   get :edit, :id => @item_alias.to_param
  #   assert_response :success
  # end
  # 
  # test "should update item_alias" do
  #   put :update, :id => @item_alias.to_param, :item_alias => @item_alias.attributes
  #   assert_redirected_to item_alias_path(assigns(:item_alias))
  # end
  # 
  # test "should destroy item_alias" do
  #   assert_difference('ItemAlias.count', -1) do
  #     delete :destroy, :id => @item_alias.to_param
  #   end
  # 
  #   assert_redirected_to item_aliases_path
  # end
end
