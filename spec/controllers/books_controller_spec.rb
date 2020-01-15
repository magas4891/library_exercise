# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }

  describe 'when user NOT sign in' do
    context 'GET #index' do
      it 'should returns successful response' do
        get :index
        expect(response).to be_successful
      end
      it 'should render index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
    context 'GET #show' do
      it 'should returns successful response' do
        get :show, params: { id: book.id }
        expect(response).to be_successful
      end
      it 'should render index template' do
        get :show, params: { id: book.id }
        expect(response).to render_template('show')
      end
    end
    context 'GET #new' do
      it 'should has status REDIRECTED' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
      it 'should redirects to login page' do
        get :new
        expect(response).to redirect_to('http://test.host/users/sign_in')
      end
    end
  end

  describe 'when user sign in' do
    before do
      sign_in user
    end
    context 'GET #index' do
      it 'should returns successful response' do
        get :index
        expect(response).to be_successful
      end
      it 'should render index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
    context 'GET #show' do
      it 'should returns successful response' do
        get :show, params: { id: book.id }
        expect(response).to be_successful
      end
      it 'should render show template' do
        get :show, params: { id: book.id }
        expect(response).to render_template('show')
      end
    end
    context 'GET #new' do
      it 'should returns successful response' do
        get :new
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
      it 'should render new template' do
        get :new
        expect(response).to render_template('new')
      end
    end
    context 'POST #create' do
      subject do
        post :create,
             params: { book: { name: Faker::Book.title,
                               description:
                                   Faker::Lorem.paragraph_by_chars(number: 300,
                                                                   supplemental: false),
                               author: Faker::Book.author,
                               user_id: user.id } }
      end
      it 'should increase Book counter in db' do
        expect { subject }.to change { Book.count }.by(1)
      end
    end

    context 'UPDATE #update' do
      it 'return status OK' do
        get :edit, params: { id: book.reload.id }
        expect(response).to have_http_status(:ok)
      end
      it 'book should have new data' do
        book.update(name: 'Updated name')
        expect(book.name).to eq 'Updated name'
      end
    end

    context 'DELETE #destroy' do
      it '#delete database record' do
        expect { book.destroy }.to change { Book.count }.by(-1)
      end
      it 'returns to index path' do
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to(books_path)
      end
    end

    context 'PUT #take' do
      subject { put :take, xhr: true, params: { id: book.id } }

      it 'increases take counter' do
        expect { subject }.to change { book.reload.taken }.by(1)
      end
      it 'change book status to FALSE' do
        expect { subject }.to change { book.reload.status }.to false
      end
      it 'create history for this book with nil "return date"' do
        expect { subject }.to change { book.reload.histories.size }.by(1)
        expect(book.reload.histories[0]['return_date']).to eq nil
      end
    end

    context 'PUT #return' do
      it 'set book status to true and update "return_date" field' do
        put :take, xhr: true, params: { id: book.id }
        put :return, xhr: true, params: { id: book.id }
        expect(book.reload.status).to eq true
        expect(book.reload.histories[0]['return_date']).not_to eq nil
      end
    end
  end
end
