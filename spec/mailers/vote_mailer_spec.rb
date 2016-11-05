require 'rails_helper'

RSpec.describe 'VoteMailer' do
  describe 'notify_user' do
    let(:user) { instance_double("User", email: 'fred@flinstone.com', name: 'Fred Flinstones') }
    let(:movie){ instance_double("Movie", :user => user, :title => "The Flinstones")}
    let(:like_mail) { VoteMailer.notify_user(:like, movie) }
    let(:hate_mail) { VoteMailer.notify_user(:hate, movie) }

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
        expect(hate_mail.body.encoded).to match(movie.title)
      end

      it 'assigns @user' do
        expect(hate_mail.body.encoded).to match(user.name)
      end

      it 'renders the like subject' do
        expect(like_mail.subject).to eql('New like for: ' + movie.title)
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

      it 'renders the hate subject' do
        expect(hate_mail.subject).to eql('New hate for: ' + movie.title)
      end

    end
  end
end