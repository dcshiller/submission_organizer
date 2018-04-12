require 'rails_helper'

RSpec.describe "home page", :type => :request do
	fixtures :users
	fixtures :articles
	fixtures :submissions
	fixtures :journals

	it 'redirects for login' do
		expect(get '/').to redirect_to new_session_path
	end

	describe 'with valid user' do
		before do
			post '/sessions', params: { user: { email: users(:one).email, password: 'testpassword' } }
		end
	
		it 'doesnt redirect for active user' do
			expect(get '/').to_not redirect_to new_session_path
		end

		it 'shows users appropriate info' do
			get '/'
			expect(response.body).to include(articles(:third_dogma).title)
			expect(response.body).not_to include(articles(:everything).title)
			expect(response.body).to include(journals(:epistemology_today).title)
			expect(response.body).not_to include(journals(:ethics_tomorrow).title)
		end
	end
end
