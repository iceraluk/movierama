require 'rails_helper'

RSpec.describe 'VoteNotification' do
  describe 'notify_user' do
    let(:user) { instance_double("User", :email => 'fred@flinstone.com') }
    let(:movie) { instance_double("Movie", :name => 'The Flinstones', user: user) }
    let(:like_mail) { VoteNotification.notify_user(:like, movie) }
    let(:hate_mail) { VoteNotification.notify_user(:hate, movie) }

    context 'like' do

      it 'renders the to email' do
        expect(like_mail.to).to eql([user.email])
      end

      it 'renders the from email' do
        expect(like_mail.from).to eql(['noreply@movierama.com'])
      end

      it 'assigns @like_or_hate' do
        expect(like_mail.body.encoded).to match('like')
      end

      it 'assigns @movie' do
        expect(hate_mail.body.encoded).to match(movie.name)
      end

      it 'assigns @user' do
        expect(hate_mail.body.encoded).to match(user.email)
      end

      it 'renders the like subject' do
        expect(like_mail.subject).to eql('New like for: ' + movie.name)
      end

    end

    context 'hate' do

      it 'renders the to email' do
        expect(hate_mail.to).to eql([user.email])
      end

      it 'renders the from email' do
        expect(hate_mail.from).to eql(['noreply@movierama.com'])
      end

      it 'assigns @like_or_hate' do
        expect(hate_mail.body.encoded).to match('hate')
      end

      it 'renders the like subject' do
        expect(hate_mail.subject).to eql('New hate for: ' + movie.name)
      end

    end
  end
end