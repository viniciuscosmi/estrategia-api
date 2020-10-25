context 'POST Projects' do
  describe 'with a valid data in project json' do
    it 'should return a project created' do
      user = create_user[1]
      json_projects = fill_projects_json(user['user']['_id'])
      request_post_projects = Projects.post(CONFIG['paths']['projects'], body: json_projects.to_json, headers: { 'Authorization' => "Bearer #{user['token']}" })
      expect(request_post_projects.code).to eq(200)
      expect(request_post_projects['project']['tasks'][0]['completed']).to eq(false)
      expect(request_post_projects['project']['tasks'][0]['name']).to eq(json_projects['tasks'][0]['name'])
      expect(request_post_projects['project']['tasks'][0]['assignedTo']).to eq(json_projects['tasks'][0]['assignedTo'])
      expect(request_post_projects['project']['title']).to eq(json_projects['title'])
      expect(request_post_projects['project']['description']).to eq(json_projects['description'])
    end
  end
end

context 'GET Projects' do
  describe 'without a specific id project' do
    it 'should return all projects' do
      project = create_project
      user = project[1]
      return_get_project = Projects.get(CONFIG['paths']['projects'], headers: { 'Authorization' => "Bearer #{user['token']}" })
      expect(return_get_project.code).to eq(200)
      expect(return_get_project['projects'].size).to be > 1
    end
  end
  describe 'with a valid id project' do
    it 'should return a project' do
      project = create_project
      user = project[1]
      return_get_project = Projects.get(CONFIG['paths']['projects']+"/#{project[0]['project']['_id']}", headers: { 'Authorization' => "Bearer #{user['token']}" })
      expect(return_get_project.code).to eq(200)
      expect(return_get_project['project']['tasks'][0]['name']).to eq(project[0]['project']['tasks'][0]['name'])
      expect(return_get_project['project']['tasks'][0]['assignedTo']).to eq(project[0]['project']['tasks'][0]['assignedTo'])
      expect(return_get_project['project']['title']).to eq(project[0]['project']['title'])
      expect(return_get_project['project']['description']).to eq(project[0]['project']['description'])
    end
  end
end

context 'PUT Projects' do
  describe 'with a valid id project' do
    describe 'with a new data projects' do
      it 'should return a project updated' do
        project = create_project
        user = project[1]
        new_project = fill_projects_json(user['user']['_id'])
        return_put_project = Projects.put(CONFIG['paths']['projects']+"/#{project[0]['project']['_id']}", body: new_project.to_json, headers: { 'Authorization' => "Bearer #{user['token']}" })
        expect(return_put_project.code).to eq(200)
        expect(return_put_project['project']['user']).to eq(project[0]['project']['user'])
        expect(return_put_project['project']['tasks'][0]['assignedTo']).to eq(project[0]['project']['tasks'][0]['assignedTo'])
        expect(return_put_project['project']['tasks'][0]['project']).to eq(project[0]['project']['tasks'][0]['project'])
        expect(return_put_project['project']['title']).not_to eq(project[0]['project']['title'])
        expect(return_put_project['project']['description']).not_to eq(project[0]['project']['description'])
        expect(return_put_project['project']['tasks'][0]['name']).not_to eq(project[0]['project']['tasks'][0]['name'])
        expect(return_put_project['project']['tasks'][0]['assignedTo']).to eq(project[0]['project']['tasks'][0]['assignedTo'])
        expect(return_put_project['project']['tasks'][0]['project']).to eq(project[0]['project']['tasks'][0]['project'])
      end
    end
  end
end

context 'DELETE Projects' do
  describe 'with a valid id project' do
    it 'should return a project deleted' do
      project = create_project
      user = project[1]
      return_delete_project = Projects.delete(CONFIG['paths']['projects']+"/#{project[0]['project']['_id']}", headers: { 'Authorization' => "Bearer #{user['token']}" })
      expect(return_delete_project.code).to eq(200)
      return_get_project = Projects.get(CONFIG['paths']['projects']+"/#{project[0]['project']['_id']}", headers: { 'Authorization' => "Bearer #{user['token']}" })
      expect(return_get_project.code).to eq(200)
      expect(return_get_project['project']).to eq(nil)
    end
  end
end
