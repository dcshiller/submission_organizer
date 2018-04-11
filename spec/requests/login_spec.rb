require 'rails_helper'

RSpec.describe "Logging In", :type => :request do
  fixtures :users

  it "logs in with good password" do
    post "/sessions", params: { user: {  email: 'test@test.com', password: 'testpassword' } }
    expect(response.status).to be(302)
 		assert_redirected_to root_path
  end

  it "logs in with good password and capitalized email" do
    post "/sessions", params: { user: {  email: 'tEsT@test.com', password: 'testpassword' } }
    expect(response.status).to be(302)
 		assert_redirected_to root_path
  end
  
	it "does not login without good password" do
    post "/sessions", params: { user: {  email: 'test@test.com', password: 'fakepassword' } }
    expect(response.status).to be(200)
 	end

  it "does not login without recognized email" do
    post "/sessions", params: { user: {  email: 'fake@test.com', password: 'fakepassword' } }
    expect(response.status).to be(200)
  end
end
