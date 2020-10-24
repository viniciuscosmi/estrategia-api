module Helpers
  require 'spec_helper'

  def create_user
    json_register = fill_register_json
    request_post_register = Auth.post(CONFIG['paths']['register'], body: json_register)
    expect(request_post_register.code).to eq(200)
    json_register
  end

end