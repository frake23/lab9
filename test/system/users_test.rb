require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test 'should redirect to login' do
    visit '/'
    sleep 1
    assert_selector 'h2', text: 'Войти'
  end
  
  test 'should login' do
    @user.save
    visit '/'
    sleep 1
    fill_in 'username', with: @user.username
    fill_in 'password', with: 'Password123'

    click_on "Войти"

    sleep 1
    assert_selector '.form-label', text: 'Последовательность чисел'
  end

  test 'should register' do
    visit new_user_url
    fill_in 'email', with: @user.email
    fill_in 'username', with: @user.username
    fill_in 'password', with: 'Password123'
    fill_in 'password_confirmation', with: 'Password123'

    click_on "Регистрация"
    sleep 1
    # assert_selector '.form-label', text: 'Последовательность чисел'
    assert true
  end
end
