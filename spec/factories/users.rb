FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:nickname) { |n| "user#{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password "password"
    password_digest User.digest("password")
    activated true
    activated_at Time.current

    factory :michael do
      id 1
      name "Michael Example"
      nickname "michael"
      email "michael@example.com"
      admin true
    end

    factory :archer do
      id 2
      name "Sterling Archer"
      nickname "archer"
      email "duchess@example.gov"
    end

    factory :lana do
      id 3
      name "Lana Kane"
      nickname "lana"
      email "hands@example.gov"
      activated false
    end

    factory :malory do
      id 4
      name "Malory Archer"
      email "boss@example.gov"
    end

    factory :hisas do
      id 5
      name "Hisashi Kamezawa"
      email "hisas@example.gov"
      allow_followed_notification true
    end

    factory :mock do
      id 6
      name "Mock"
      email "mock@example.com"
      nickname "mock"
      provider "twitter"
      twitter_uid 123545
    end
  end
end
