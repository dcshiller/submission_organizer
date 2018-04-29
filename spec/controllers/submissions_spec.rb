require 'rails_helper'

RSpec.describe SubmissionsController, type: 'request' do
	fixtures :users
	fixtures :submissions	

	before do
    login_as(submissions(:one).user)
	end	

	it 'gets index page' do
		get '/submissions'
		assert_response 200
	end

	it 'gets show page' do
		get '/submissions/1'
		assert_response 200
		expect(response.body).to include(submissions(:one).article.title)
	end
	
  it 'doesnt get show page for other users submission' do
		expect{ get '/submissions/2' }.to raise_error(Pundit::NotAuthorizedError)
	end

	it 'gets new page' do
		get '/submissions/new'
		assert_response 200
	end

	it 'gets edit page' do
		get '/submissions/1/edit'
		assert_response 200
		expect(response.body).to include(submissions(:one).article.title)
	end

  it 'doesnt get edit page for other users submission' do
		expect{ get '/submissions/2/edit' }.to raise_error(Pundit::NotAuthorizedError)
	end

  it 'makes edits' do	
		patch '/submissions/1', params: { submission: { journal_id: 2 } }
		assert_response 302
		expect(submissions(:one).reload.journal_id).to eq(2)
	end	
end
