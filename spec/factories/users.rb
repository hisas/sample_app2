FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "password"
    password_digest User.digest("password")
    activated true
    activated_at Time.zone.now

    factory :michael do
      id 1
      name "Michael Example"
      email "michael@example.com"
      admin true
    end

    factory :archer do
      id 2
      name "Sterling Archer"
      email "duchess@example.gov"
    end

    factory :lana do
      id 3
      name "Lana Kane"
      email "hands@example.gov"
      activated false
    end

    factory :malory do
      id 4
      name "Malory Archer"
      email "boss@example.gov"
    end
  end
end
