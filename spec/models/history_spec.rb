# frozen_string_literal: true

RSpec.describe History, type: :model do
  let!(:user) { create(:valid_user) }
  let!(:book) { create(:valid_book) }
  let!(:history) { create(:valid_history) }

  context 'assotiation' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_stored_in(collection: 'histories') }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  context 'validation' do
    it { is_expected.to have_field(:take_date).of_type(Date) }
    it { is_expected.to have_field(:return_date)
      .of_type(Date).with_default_value_of(nil)
    }
  end

  context 'creating' do
    it ' with valid params is VALID' do
      expect(history).to be_valid
    end
    it 'without return_date is VALID' do
      expect(build(:valid_history, return_date: nil)).to be_valid
    end
  end

  context 'deleting' do
    it 'count of history became less on 1' do
      expect { history.destroy }.to change { History.count }.by(-1)
    end
  end
end
