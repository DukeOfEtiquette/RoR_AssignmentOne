require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @adminuser = User.create(username: "adam", email: "adam@example.com", password: "Passw0rd", admin: true) # admin user
  end
  
  test "get new category form and create category" do
    sign_in_as(@adminuser, 'Passw0rd')
    get new_category_path
    assert_template 'categories/new'
    
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: "sports" }
    end
    
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@adminuser, 'Passw0rd')
    session[:user_id] = @adminuser.id
    get new_category_path
    assert_template 'categories/new'
    
    assert_no_difference 'Category.count' do
      post categories_path, category: { name: " " }
    end
    
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end