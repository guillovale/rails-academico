require 'test_helper'

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get usuarios_new_url
    assert_response :success
  end

end
