Faker::Config.locale = :ja

User.create!(name:  "Example User",
             nickname: "example",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.current)

99.times do |n|
  name  = Faker::Name.name
  nickname = Faker::Internet.user_name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               nickname: nickname,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.current)
end

users = User.order(:created_at).take(6)
50.times do
  content = Yoshida::Text.sentence
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
