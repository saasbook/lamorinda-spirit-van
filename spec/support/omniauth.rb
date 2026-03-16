# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:entra_id] = OmniAuth::AuthHash.new({
      provider: "entra_id",
      uid: "12345",
      info: { email: "dispatcher@example.com" }
    })
  end

  config.after(:each) do
    OmniAuth.config.mock_auth[:entra_id] = nil
  end
end
