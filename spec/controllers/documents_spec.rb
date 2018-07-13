require 'rails_helper'

RSpec.describe DocumentsController, type: 'request' do
  fixtures :users
  fixtures :articles
  fixtures :submissions
  fixtures :submission_events
  fixtures :documents

  before do
    login_as submission_events(:one).user
  end

  it 'gets show page' do
    DocumentsController.any_instance.stub(:send_file)
    DocumentsController.any_instance.stub(:default_render)
    get '/documents/1'
    assert_response 200
  end

  it 'doesnt get show page for other users submission_events' do
    expect{ get '/documents/2' }.to raise_error(Pundit::NotAuthorizedError)
  end
end
