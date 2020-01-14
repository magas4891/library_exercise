require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }

  describe 'when user sign in' do
    before do
      sign_in user
    end
    context 'POST #create' do
      subject do
        post :create,
             xhr: true,
             params: { book_id: book.id,
                       like: { user_id: user.id } }
      end
      it 'should increase book comments counter in db' do
        expect { subject }.to change { Like.count }.by(1)
      end
    end
  end
end
