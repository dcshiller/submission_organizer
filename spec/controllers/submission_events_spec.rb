require 'rails_helper'

RSpec.describe SubmissionEventsController, type: 'request' do
	fixtures :users
	fixtures :articles
  fixtures :submissions
  fixtures :submission_events	

	before do
    login_as(submission_events(:one).user)
	end	

	it 'gets index page' do
		get '/submission_events'
		assert_response 200
	end

	it 'gets show page' do
		get '/submission_events/1'
		assert_response 200
	end
	
  it 'doesnt get show page for other users submission_events' do
		expect{ get '/submission_events/2' }.to raise_error(Pundit::NotAuthorizedError)
	end

	it 'gets new page' do
		get '/submission_events/new'
		assert_response 200
	end

	it 'gets edit page' do
		get '/submission_events/1/edit'
		assert_response 200
	end

  it 'doesnt get edit page for other users submission_events' do
		expect{ get '/submission_events/2/edit' }.to raise_error(Pundit::NotAuthorizedError)
	end

  it 'makes edits' do	
		put '/submission_events/1', params: { submission_event: { event_type: 'decision' } }
		assert_response 302
		expect(submission_events(:one).reload.event_type).to eq('decision')
	end	
end
