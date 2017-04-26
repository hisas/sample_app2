FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "password"
    password_digest User.digest("password")

    factory :michael do
      name "Michael Example"
      email "michael@example.com"
      admin true
    end

    factory :archer do
      name "Sterling Archer"
      email "duchess@example.gov"
    end
  end
end
