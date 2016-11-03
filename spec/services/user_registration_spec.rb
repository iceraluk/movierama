require 'rails_helper'

RSpec.describe 'UserRegistration' do
  let(:auth_hash) {{
    'uid' => '12345',
      'info' => {
      'name' => 'John McFoo',
      'email'=> 'john@mcfoo.com'
    }
  }}

  context 'new' do
    it 'saves user email' do
      expect(UserRegistration.new(auth_hash).user.email).to eq (auth_hash['info']['email'])
    end
  end
end