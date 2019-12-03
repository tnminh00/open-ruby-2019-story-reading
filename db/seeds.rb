100.times do |n|
  name = FFaker::Book.title
  author = FFaker::Name.name
  introduction = FFaker::Lorem.paragraph
  story = Story.create(name: name, author: author, introduction: introduction)
  10.times do |n|
    name_chapter = "Chapter #{n+1}: " + FFaker::Book.title
    content = FFaker::Lorem.paragraphs Settings.paragraph
    story.chapters.create!(name: name_chapter, content: content)
  end
end
