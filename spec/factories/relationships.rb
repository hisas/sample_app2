FactoryGirl.define do
  factory :relationship do
    factory :one do
      follower_id 1
      followed_id 3
    end

    factory :two do
      follower_id 1
      followed_id 4
    end

    factory :three do
      follower_id 3
      followed_id 1
    end

    factory :four do
      follower_id 2
      followed_id 1
    end
  end
end
