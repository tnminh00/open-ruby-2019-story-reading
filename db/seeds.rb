User.create(name: "admin", email: "admin@gmail.com", password: "Abc123", is_admin: true)
User.create(name: "user1", email: "user1@gmail.com", password: "Abc123")
User.create(name: "user2", email: "user2@gmail.com", password: "Abc123")
100.times do |n|
  name = FFaker::Book.title
  author = FFaker::Name.name
  introduction = FFaker::Lorem.paragraph
  story = Story.create(name: name, author: author, introduction: introduction)
  10.times do |n|
    name_chapter = FFaker::Book.title
    paragraph = FFaker::Lorem.paragraphs Settings.paragraph
    content = ""
    paragraph.each do |p|
      content = content + "&emsp;&emsp;" + p + "<br><br>"
    end
    story.chapters.create!(name: name_chapter, content: content, chapter_number: n+1)
  end
end

50.times do
  name = FFaker::Book.genre
  Category.create!(name: name)  
end

Story.all.each do |s|
  sample = Category.all.sample Settings.sample
  s.category_stories.create category: sample.first
  s.category_stories.create category: sample.second
end

Story.where("id < 20").each do |s|
  s.update_attributes sales_type: :sale, price: 5.99
end
