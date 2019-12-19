require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }
  describe 'when user NOT sign in' do
    context 'GET #index' do
      it 'returns successful response' do
        get :index
        expect(response).to be_successful
      end
      it 'render index template' do
        get :index
        expect(response).to render_template("index")
      end
    end
    context 'GET #show' do
      it 'returns successful response' do
        get :show, params: { id: book.id }
        expect(response).to be_successful
      end
      it 'render index template' do
        get :show, params: { id: book.id }
        expect(response).to render_template("show")
      end
    end
  end
end
