FactoryGirl.define do
  factory :user do
    name "test"
    email "test"
    password "password"
    password_digest User.digest("password")

    factory :michael do
      name "Michael Example"
      email "michael@example.com"
    end

    factory :archer do
      name "Sterling Archer"
      email "duchess@example.gov"
    end
  end
end
