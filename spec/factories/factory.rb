FactoryBot.define do

  factory :user do
    name {FFaker::Name.name}
    email {FFaker::Internet.email}
    password {"password"}
  end

  factory :story do
    name {FFaker::Book.title}
    author {FFaker::Name.name}
    introduction {FFaker::Lorem.paragraph}

    factory :story_with_chapter do
      after(:create) do |story|
        create(:chapter, story: story)
      end
    end
  end

  factory :chapter do
    name {FFaker::Book.title}
    content {FFaker::Lorem.paragraph}
    chapter_number {Random.rand(1..10)}
  end
end
