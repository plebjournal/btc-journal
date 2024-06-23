# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserTransactionsMovingSum do
  describe '#for_user' do
    subject { UserTransactionsMovingSum.for_user(user) }
    context 'when a user has one transactions' do
      let!(:user) { create(:user) }
      let!(:tx) { create(:transaction, user: user) }

      it 'gives back the btc and fiat amount' do
        sum = subject
        expect(sum.btc_at_date(Date.current)).to eq(tx.as_btc)
        expect(sum.fiat_at_date(Date.current)).to eq(tx.fiat)
      end

      it 'returns 0 for amount when asking for the past before any tx happened' do
        sum = subject
        expect(sum.btc_at_date('2024-06-01'.to_date)).to eq(0)
        expect(sum.fiat_at_date('2024-06-01'.to_date)).to eq(0)
      end

      it 'returns normal values when asking for a date in the future' do
        sum = subject
        expect(sum.btc_at_date(Date.current + 1.year)).to eq(tx.as_btc)
        expect(sum.fiat_at_date(Date.current + 1.year)).to eq(tx.fiat)
      end
    end

    context 'when a user has multiple BUY transactions' do
      let!(:user) { create(:user) }
      let!(:tx1) { create(:transaction, user: user) }
      let!(:tx2) { create(:transaction, :last_week, user: user) }

      it 'should give back the btc and fiat amount' do
        sum = subject
        expected_btc = tx1.as_btc + tx2.as_btc
        expected_fiat = tx1.fiat + tx2.fiat

        expect(sum.btc_at_date(Date.current)).to eq(expected_btc)
        expect(sum.fiat_at_date(Date.current)).to eq(expected_fiat)
      end
    end

    context 'when a user has multiple BUY transactions' do
      let!(:user) { create(:user) }
      let!(:tx1) { create(:transaction, user: user) }
      let!(:tx2) { create(:transaction, :last_week, user: user) }

      it 'should give back the btc and fiat amount' do
        sum = subject
        expected_btc = tx1.as_btc + tx2.as_btc
        expected_fiat = tx1.fiat + tx2.fiat

        expect(sum.btc_at_date(Date.current)).to eq(expected_btc)
        expect(sum.fiat_at_date(Date.current)).to eq(expected_fiat)
      end
    end

    context 'when a user has 1 buy and 1 income transaction' do
      let!(:user) { create(:user) }
      let!(:tx1) { create(:transaction, user: user) }
      let!(:tx2) { create(:transaction, :income, :last_week, user: user) }

      it 'should give back the btc and fiat amount' do
        sum = subject
        expected_btc = tx1.as_btc + tx2.as_btc
        expected_fiat = tx1.fiat

        expect(sum.btc_at_date(Date.current)).to eq(expected_btc)
        expect(sum.fiat_at_date(Date.current)).to eq(expected_fiat)
      end
    end
  end
end