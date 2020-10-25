module Projects
  include HTTParty
  base_uri CONFIG['hosts']

  def fill_projects_json(assignedTo = Faker::Name.middle_name )
    json = File.read('templates/projects/projects.json')
    json_parsed = JSON.parse(json)
    json_parsed['title'] = Faker::Lorem.word
    json_parsed['description'] = Faker::Lorem.word
    json_parsed['tasks'][0]['name'] = Faker::Lorem.word
    json_parsed['tasks'][0]['assignedTo'] = assignedTo
    json_parsed
  end
end