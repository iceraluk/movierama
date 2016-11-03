require 'rails_helper'

RSpec.describe 'VotingBooth' do
  subject { VotingBooth.new(user, movie) }
  let(:subject_no_email) { VotingBooth.new(user, movie_no_email) }
  let(:user){instance_double("User", :email => 'fred@flinstone.com')}
  let(:user_no_email){instance_double("User", :email => nil)}
  let(:likers_or_haters) {instance_double(Ohm::MutableSet, :add => true, :delete => true, :size => 1)}
  let(:movie){instance_double("Movie", :user => user, :likers => likers_or_haters, :haters => likers_or_haters, :update => true)}
  let(:movie_no_email){instance_double("Movie", :user => user_no_email, :likers => likers_or_haters, :haters => likers_or_haters, :update => true)}
  let(:like){:like}
  let(:hate){:hate}

  describe 'voting' do
    context 'user has email' do
      it 'sends like email' do
        expect{subject.vote(like)}.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
      it 'sends hate email' do
        expect{subject.vote(hate)}.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
    context 'user does not have email' do
      it 'does not send email' do
        expect{subject_no_email.vote(like)}.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end

end