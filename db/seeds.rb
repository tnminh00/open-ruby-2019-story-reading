100.times do |n|
  name = FFaker::Book.title
  author = FFaker::Name.name
  introduction = FFaker::Lorem.sentences
  Story.create!(name: name, author: author, introduction: introduction)
end
