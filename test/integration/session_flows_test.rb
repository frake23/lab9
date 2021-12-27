require "test_helper"

class SessionFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'unauthorized user will see login page' do
    get root_path
    assert_redirected_to '/login'
  end

  test 'user with incorrect credentials will be redirected to login page' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 8)
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    post '/login', params: { username: user.username, password: "#{user.password}D" }
    assert_redirected_to '/login'
  end

  test 'user with correct credentials will see sequence input' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 8)
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    post '/login', params: { username: user.username, password: user.password }
    assert_redirected_to '/'
  end

  test 'user can logout' do
    username = Faker::Internet.username
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 8)
    user = User.create(username: username, email: email, password: password, password_confirmation: password)
    post '/login', params: { username: user.username, password: password }
    delete '/logout'

    assert_redirected_to '/login'
  end
end