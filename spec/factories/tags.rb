module Karajoker
  FactoryGirl.define do
    factory :tag, class: Karajoker::Entity::Tag do
      trait :pop do
        name 'Pop'
      end
      trait :rock do
        name 'Rock'
      end
    end
  end
end
