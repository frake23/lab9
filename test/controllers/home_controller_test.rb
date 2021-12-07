require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/'
    assert_response :success
  end

  test "should get error" do
    post '/', params: {arr: 's123 s123'}
    assert_response :success
    assert_nil assigns[:distances]
    assert_nil assigns[:max_distance]

    assert_equal 'В строке могут быть только числа или пробелы / может быть не более одного пробела между числами', assigns[:error]
  end

  test "should return correct answer" do
    post '/', params: {arr: '1 5 25 0 625 22 5 5'}
    assert_response :success
    assert_nil assigns[:error]

    assert_equal [[1, 5, 25], [625], [5, 5]], assigns[:distances]
    assert_equal [1, 5, 25], assigns[:max_distance]
  end
end
