require 'rails_helper'

describe PasswordResetsController do
  describe 'GET show' do
    it 'renders the show template' do
      get :show, id: '123'
      expect(response).to render_template :show
    end
  end
end