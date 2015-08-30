require 'rails_helper'

describe ForgotPasswordsController do
  describe 'GET new' do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context "with blank input" do
      it "redirects to the forgot password page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
    end

    context "with an existing email" do
      before do
        @user = double('user', email: 'test@example.com')
        expect(User).to receive(:where).and_return([@user])
      end

      it "redirects to the root path" do
        post :create, email: @user.email
        expect(response).to redirect_to root_path
      end

      it "sends an email" do
        post :create, email: @user.email
        expect(ActionMailer::Base.deliveries.last.to).to eq(['test@example.com'])
      end
    end

    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, 'not_an_email@example.com'
        expect(response).to redirect_to forgot_password_path
      end
    end
  end
end