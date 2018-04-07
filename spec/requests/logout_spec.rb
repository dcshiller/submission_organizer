require 'rails_helper'
require 'spec_helper'

describe SessionsController, type: :controller do
	fixtures :users

	it "logs out" do
		session[:user_id] = User.first.id
		get :destroy 
		expect(session[:user_id]).to be_nil
		assert_redirected_to new_session_url		
	end
end

