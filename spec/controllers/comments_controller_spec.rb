require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
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
                       comment: { comment: 'This is a comment fot the book',
                                  commenter: user.name,
                                  user_id: user.id } }
      end
      it 'should increase book comments counter in db' do
        expect { subject }.to change { Comment.count }.by(1)
      end
      it 'should increase book comments counter in db' do
        subject
        expect(book.comments[0].comment).to eq 'This is a comment fot the book'
      end
    end
  end

end
