context 'POST Auth' do
  describe 'with a valid register json' do
    it 'should return the user created' do
      json_register = fill_register_json
      request_post_register = Auth.post(CONFIG['paths']['register'], body: json_register)
      expect(request_post_register.code).to eq(200)
      expect(request_post_register['user']['name']).to eq(json_register['name'])
    end
  end
  describe 'with a valid data in register json' do
    it 'should return the user authenticate' do
      user = create_user[0]
      json_authenticate = fill_authenticate_json(user['email'], user['password'])
      request_post_authenticate = Auth.post(CONFIG['paths']['authenticate'], body: json_authenticate)
      expect(request_post_authenticate.code).to eq(200)
      expect(user['name']).to eq(request_post_authenticate['user']['name'])
      expect(user['email']).to eq(request_post_authenticate['user']['email'])
      expect(request_post_authenticate['token']).not_to be_empty
    end
  end
  describe 'with a invalid data in register json' do
    it 'shouldnt return the user authenticate' do
      json_authenticate = fill_authenticate_json
      request_post = Auth.post(CONFIG['paths']['authenticate'], body: json_authenticate)
      expect(request_post.code).to eq(400)
      expect(request_post['error']).to eq('User not found')
    end
  end
end
