require 'rails_helper'

RSpec.describe PasswordsController, type: 'request' do
  fixtures :users

  it 'renders forgot' do
    get '/forgot'
    assert_response 200
  end

  it 'sets password reset token' do
    user = User.find(1)
    refute user.reload.reset_token
    get '/reset_password?email=' + user.email
    assert user.reload.reset_token
    assert_response 200
  end

  it 'renders new password with token' do
    user = User.find(1)
    user.set_reset_token!
    get '/passwords/new', params: { reset_token: user.reset_token }
    assert_response 200
  end

  it 'redirects from new password without token' do
    user = User.find(1)
    get '/passwords/new'
    assert_response 302
  end

  it 'creates new password for user logged in' do
    user = User.find(1)
    login_as user
    user.set_reset_token!
    post '/passwords', params: { user: { password: "testpass" } }
    assert_nil user.reload.reset_token
    assert_response 302
  end
end
