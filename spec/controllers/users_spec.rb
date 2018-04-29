require 'rails_helper'

RSpec.describe UsersController, type: 'request' do
	fixtures :users

	before do
    login_as(users(:one))
	end	


  it 'gets edit page for proper user' do
    get '/users/1/edit'
    assert_response 200
  end

  it 'doesnt get edit page' do
		expect { get '/users/2/edit' }.to raise_error(Pundit::NotAuthorizedError)
	end

  it 'makes edits for proper user' do	
		patch '/users/1', params: { user: { email: 'new@test.com' } }
		assert_response 302
		expect(users(:one).reload.email).to eq('new@test.com')
	end	
  
  it 'raises error for cross-user update' do
		expect { patch '/users/2', params: { user: { email: 'new@test.com' } } }.
      to raise_error(Pundit::NotAuthorizedError)
	end
end
