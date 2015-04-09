module Karajoker
  FactoryGirl.define do
    factory :karaoke, class: Karajoker::Entity::Karaoke do
      trait :hello_1 do
        title 'hello_1'
        youtube_id '12345'
        author 'author1'
      end
      trait :hello_2 do
        title 'hello_2'
        youtube_id '1234'
        author 'author2'
      end
    end
  end
end
