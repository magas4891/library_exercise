require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:valid_user) }

  context 'assotiation' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_stored_in(collection: 'users') }
    it { is_expected.to have_many(:books).with_dependent(:destroy)  }
    it { is_expected.to have_many(:likes) }
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:password).with_minimum(6) }
  end

  context "creating" do
    it " with valid params is VALID" do
      expect(user).to be_valid
    end
    it 'without email is INVALID' do
      expect(user = build(:valid_user, email: nil)).to_not be_valid
    end
    it 'without password is INVALID' do
      expect(user = build(:valid_user, password: nil)).to_not be_valid
    end
    it 'without password-confirmation is INVALID' do
      expect(user = build(:valid_user, password_confirmation: '121212')).to_not be_valid
    end
    it 'without name is INVALID' do
      expect(user = build(:valid_user, name: nil)).to_not be_valid
    end
  end

  context "deleting" do
    it 'count of users became less on 1' do
      expect { user.destroy }.to change { User.count }.by(-1)
    end
  end
end
