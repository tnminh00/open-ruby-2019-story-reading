  FactoryBot.define do

  factory :user do
    sequence(:name) {|n| "Name #{n}"}
    sequence(:email) {|n| "test-#{n}@gmail.com"}
    password {"Abc@123"}
    password_confirmation {"Abc@123"}

    factory :user_with_chapter do
      after(:create) do |user|
        story = create :story
        chapter = create :chapter, story: story
        user.histories << create(:history, user: user, chapter: chapter)
      end
    end
  end

  factory :story do
    sequence(:name) {|n| "Story #{n}"}
    sequence(:author) {|n| "Author #{n}"}
    introduction {FFaker::Lorem.paragraph}

    factory :story_with_chapter do
      after(:create) do |story|
        create(:chapter, story: story)
      end
    end

    factory :story_with_category do
      after(:create) do |story|
        category1 = create :category
        category2 = create :category
        story.category_stories << create(:category_story, story: story, category: category1)
        story.category_stories << create(:category_story, story: story, category: category2)
      end
    end
  end

  factory :chapter do
    sequence(:name) {|n| "Chapter #{n}"}
    content {FFaker::Lorem.paragraph}
    sequence(:chapter_number) {|n| n}
  end

  factory :category do
    sequence(:name) {|n| "Category #{n}"}
    
    factory :category_with_story do
      after(:create) do |category|
        story = create :story
        category.category_stories << create(:category_story, story: story, category: category)
      end
    end
  end

  factory :category_story do
    story
    category
  end

  factory :history do
    user
    chapter
  end
end
