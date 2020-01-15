# frozen_string_literal: true

RSpec.describe Like, type: :model do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }
  let!(:like) { create(:valid_like) }

  context 'assotiation' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_stored_in(collection: 'likes') }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  context 'creating' do
    it ' with valid params is VALID' do
      expect(like).to be_valid
    end
  end

  context 'deleting' do
    it 'count of likes became less on 1' do
      expect { like.destroy }.to change { Like.count }.by(-1)
    end
  end
end
