require 'rails_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    before(:each) do
      @user = User.new(email: 'test@example.com', password: 'password', encrypted_password: '$2a$10$F3tAtopwTweEt4.Ri3jZ.OgwCY4Yy6AWzct85u92aQKzNmScMZK2a', id: 1)
      expect(User).to receive(:where).and_return([@user])
    end

    context 'with valid credentials' do
      it 'sets the user in the session' do
        post :create, email: @user.email, password: 'password'
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    context 'with invalid credentials' do
      it 'does not set the user in the session' do
        post :create, email: @user.email, password: 'not_the_correct_password'
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the sign in path' do
        post :create, email: @user.email, password: 'not_the_correct_password'
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'GET destroy' do
    before do
      session[:user_id] = '123'
      get :destroy
    end

    it 'removes the user from the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to root_path
    end
  end
end