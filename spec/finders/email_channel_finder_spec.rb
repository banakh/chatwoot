require 'rails_helper'

describe ::EmailChannelFinder do
  include ActionMailbox::TestHelper
  let!(:channel_email) { create(:channel_email) }

  describe '#perform' do
    context 'with cc mail' do
      let(:reply_cc_mail) { create_inbound_email_from_fixture('reply_cc.eml') }

      it 'return channel with cc email' do
        channel_email.update(email: 'test@example.com')
        channel = described_class.new(reply_cc_mail.mail).perform
        expect(channel).to eq(channel_email)
      end
    end

    context 'with to mail' do
      let(:reply_mail) { create_inbound_email_from_fixture('reply.eml') }

      it 'return channel with to email' do
        channel_email.update(email: 'test@example.com')
        channel = described_class.new(reply_mail.mail).perform
        expect(channel).to eq(channel_email)
      end
    end
  end
end
