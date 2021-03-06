require 'spec_helper'

RSpec.describe Spree::BillingIntegration::OpenpayGateway::Cash, type: :model do
  describe '#provider_class' do
    specify { expect(subject.provider_class).to eq Spree::Conekta::Provider }
  end

  describe '#payment_source_class' do
    specify { expect(subject.payment_source_class).to eq Spree::ConektaPayment }
  end

  describe '#card?' do
    specify { expect(subject.card?).to eq(false) }
  end

  describe '#auto_capture?' do
    specify { expect(subject.auto_capture?).to eq(false) }
  end

  describe '#method_type' do
    specify { expect(subject.method_type).to eq 'conekta' }
  end
end
