FactoryGirl.define do
  factory :micropost do
    user_id 1
    sequence(:content) { Faker::Lorem.sentence(5) }
    sequence(:created_at) { 42.days.ago }

    factory :orange do
      content "I just ate an orange!"
      created_at 10.minutes.ago
    end

    factory :apple do
      content "I just ate an apple"
      created_at 10.minutes.ago
    end

    factory :tau_manifesto do
      content "Check out the @tauday site by @mhartl: http://tauday.com"
      created_at 3.years.ago
      user_id 2
    end

    factory :cat_video do
      content "Sad cats are sad: http://youtu.be/PKffm2uI4dk"
      created_at 2.hours.ago
      user_id 3
    end

    factory :most_recent do
      content "Writing a short test!"
      created_at Time.current
      user_id 4
    end

    factory :reply do
      content "@archer hello archer"
      created_at Time.current
      user_id 1
    end

    factory :postA do
      id 5000
      content "このツイートに返信してくれたら5000兆円あげます。"
      created_at Time.current
      user_id 1
    end

    factory :postB do
      content "5000兆円欲しいです！"
      created_at Time.current
      user_id 1
      reply_nickname "michael"
      reply_micropost 5000
    end
  end
end
