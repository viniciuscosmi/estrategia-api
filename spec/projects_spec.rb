describe 'POST Projects' do
  describe 'with a valid data in project json' do
    it 'should return a project created' do
      user = create_user[1]
      json_projects = fill_projects_json(user['user']['_id'])
      request_post_projects = Projects.post(CONFIG['paths']['projects'], body: json_projects.to_json, headers: { 'Content-Type'=> 'application/json' , 'Authorization' => "Bearer #{user['token']}" })
      expect(request_post_projects.code).to eq(200)
      expect(request_post_projects['project']['tasks'][0]['completed']).to eq(false)
      expect(request_post_projects['project']['tasks'][0]['name']).to eq(json_projects['tasks'][0]['name'])
      expect(request_post_projects['project']['tasks'][0]['assignedTo']).to eq(json_projects['tasks'][0]['assignedTo'])
      expect(request_post_projects['project']['title']).to eq(json_projects['title'])
      expect(request_post_projects['project']['description']).to eq(json_projects['description'])
    end
  end
  describe 'with a invalid user in project json' do
    it 'shouldnt return the project created' do
      json_projects = fill_projects_json
      request_post_projects = Projects.post(CONFIG['paths']['register'], body: json_projects)
      expect(request_post_projects.code).to eq(400)
      expect(request_post_projects['error']).to eq('Registration failed')
    end
  end
end