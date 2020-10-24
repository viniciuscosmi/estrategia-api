module Auth
  include HTTParty
  base_uri CONFIG['hosts']

  def fill_register_json
    json = File.read('templates/auth/register.json')
    json_parsed = JSON.parse(json)
    json_parsed['name'] = Faker::Name.name + Faker::Number.number.to_s
    json_parsed['email'] = Faker::Internet.email
    json_parsed['password'] = Faker::Internet.password
    json_parsed
  end

  def fill_authenticate_json(email = Faker::Internet.email, password = Faker::Internet.password)
    json = File.read('templates/auth/authenticate.json')
    json_parsed = JSON.parse(json)
    json_parsed['email'] = email
    json_parsed['password'] = password
    json_parsed
  end
end
