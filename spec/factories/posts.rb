FactoryBot.define do
  factory :post do
    id                 {"1"}
    vocab              {"言葉"}
    definition         {"言葉言葉言葉言葉言葉言葉言葉言葉"}
    example            {"言葉言葉言葉言葉言葉言葉言葉言葉"}
    image              {File.open("#{Rails.root}/public/images/test_image.jpg")}
    created_at         { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user_id            {"1"}
  end
end