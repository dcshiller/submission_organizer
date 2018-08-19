require 'rails_helper'

RSpec.describe PasswordsController, type: 'request' do
  fixtures :users

  it 'sets password reset token' do
    user = User.find(1)
    refute user.reload.reset_token
    get '/reset_password?email=' + user.email
    assert user.reload.reset_token
    assert_response 200
  end

  it 'doesnt get show page for other users submission_events' do
  end
end
