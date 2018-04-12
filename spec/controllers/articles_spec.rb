require 'rails_helper'

RSpec.describe ArticlesController, type: 'request' do
	fixtures :users
	fixtures :articles	

	before do
    login_as(articles(:third_dogma).user)
	end	

	it 'gets index page' do
		get '/articles'
		assert_response 200
	end

	it 'gets show page' do
		get '/articles/1'
		assert_response 200
		expect(response.body).to include(articles(:third_dogma).title)
	end

	it 'gets new page' do
		get '/articles/new'
		assert_response 200
	end

	it 'gets edit page' do
		get '/articles/1/edit'
		assert_response 200
		expect(response.body).to include(articles(:third_dogma).title)
	end

	it 'makes edits' do	
		patch '/articles/1', params: { article: { title: 'More than two dogmas' } }
		assert_response 302
		expect(articles(:third_dogma).reload.title).to eq('More than two dogmas')
	end	
end
