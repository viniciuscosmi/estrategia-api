describe 'POST Register' do
  describe 'with a valid register json' do
    it 'should return the user created' do
      json_register = fill_register_json
      request_post = Auth.post(CONFIG['paths']['register'], body: json_register)
      expect(request_post.code).to eq(200)
      expect(request_post.parsed_response['user']['name']).to eq(json_register['name'])
    end
  end
end