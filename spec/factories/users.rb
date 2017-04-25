FactoryGirl.define do
  factory :user do
    name 'Michael Example'
    email 'michael@example.com'
    password 'password'
    password_digest User.digest('password')
  end
end
