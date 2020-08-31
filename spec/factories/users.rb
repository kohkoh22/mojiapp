FactoryBot.define do
  factory :user do
    id                    {"1"}
    nickname              {"abe"}
    image                 {File.open("#{Rails.root}/public/images/test_image.jpg")}
    email                 {"sample@sample.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
  end
end