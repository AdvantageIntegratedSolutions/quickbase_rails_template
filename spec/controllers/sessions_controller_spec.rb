require 'rails_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    it 'sets the user in the session' do
      user = User.find(1)
      post :create, username: user.email, password: 'password'
      expect(session[:user_id]).to eq(1)
    end
  end
end