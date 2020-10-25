module Helpers
  require 'spec_helper'

  def create_user
    json_register = fill_register_json
    request_post_register = Auth.post(CONFIG['paths']['register'], body: json_register)
    expect(request_post_register.code).to eq(200)
    [json_register, request_post_register]
  end

  def create_project
    user = create_user[1]
    json_projects = fill_projects_json(user['user']['_id'])
    request_post_projects = Projects.post(CONFIG['paths']['projects'], body: json_projects.to_json, headers: { 'Content-Type'=> 'application/json' , 'Authorization' => "Bearer #{user['token']}" })
    expect(request_post_projects.code).to eq(200)
    [request_post_projects, user]
  end

end