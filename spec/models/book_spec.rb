require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }

  context 'assotiation' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_stored_in(collection: 'books') }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).with_dependent(:destroy) }
    it { is_expected.to have_many(:histories) }
    it { is_expected.to have_many(:likes) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:author) }
  end

  context "creating" do
    it " with valid params is VALID" do
      expect(book).to be_valid
    end
    it 'without name is INVALID' do
      expect(book = build(:valid_book, name: nil)).to_not be_valid
    end
    it 'without description is INVALID' do
      expect(book = build(:valid_book, description: nil)).to_not be_valid
    end
    it 'without author is INVALID' do
      expect(book = build(:valid_book, author: nil)).to_not be_valid
    end
  end

  context "deleting" do
    it 'count of books became less on 1' do
      expect { book.destroy }.to change { Book.count }.by(-1)
    end
  end
end
