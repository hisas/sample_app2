FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "password"
    password_digest User.digest("password")
    activated true
    activated_at Time.zone.now

    factory :michael do
      name "Michael Example"
      email "michael@example.com"
      admin true
    end

    factory :archer do
      name "Sterling Archer"
      email "duchess@example.gov"
    end

    factory :lana do
      name "Lana Kane"
      email "hands@example.gov"
      activated false
    end
  end
end
