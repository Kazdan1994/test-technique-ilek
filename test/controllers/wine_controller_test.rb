require 'test_helper'

class WineControllerTest < ActionDispatch::IntegrationTest
  include Pagy::Backend

  setup do
    Wine.__elasticsearch__.create_index! force: true
    Wine.import
  end

  test 'should get index' do
    get root_path
    assert_response :success
    assert_equal 6, assigns(:wines).length
  end

  test 'should get show' do
    id = 1
    get wine_path(id)
    assert_response :success
    assert_equal Wine.find(id), assigns(:wine)
  end

  test 'should search wines' do
    Wine.__elasticsearch__.refresh_index!
    get root_path, params: { q: '2000 André Family Wines Small Lot Touriga Nacional' }
    assert_response :success
    assert_equal 4, assigns(:wines).length
  end
end
