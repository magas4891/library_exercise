# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }
  let!(:comment) { create(:valid_comment) }

  context 'assotiation' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_stored_in(collection: 'comments') }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:comment) }
  end

  context 'creating' do
    it ' with valid params is VALID' do
      expect(comment).to be_valid
    end
    it 'without comment is INVALID' do
      expect(build(:valid_comment, comment: nil)).to_not be_valid
    end
  end

  context 'deleting' do
    it 'count of comments became less on 1' do
      expect { comment.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
