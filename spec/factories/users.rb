FactoryBot.define do
  factory :user do
    name { "John Smith" }
    email { "john@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    location { "未設定" }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "Steve Johnson" }
    email { "steve@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    location { "未設定" }
    admin { true }
  end
end
