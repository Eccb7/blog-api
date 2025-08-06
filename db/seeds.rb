require 'faker'
require 'securerandom'

# Clear existing data
# Clear existing join table entries first
ArticleTag.delete_all
Article.destroy_all
Tag.destroy_all

# Create sample tags with unique names
tags = []
10.times do
  tag = Tag.find_or_create_by!(
    name: Faker::Hacker.adjective.downcase.parameterize
  ) do |new_tag|
    new_tag.count = rand(1..10)
  end
  tags << tag
end

# Create sample articles with proper tag associations
50.times do |i|
  title = "#{Faker::Books::Dune.quote} #{SecureRandom.hex(4)}"
  
  article = Article.find_or_create_by!(title: title) do |new_article|
    new_article.content = Faker::Lorem.paragraphs(number: 5).join("\n\n")
    new_article.published_at = rand(1..365).days.ago
  end

  # Associate 3 random tags through the join table
  tags.sample(3).each do |tag|
    ArticleTag.find_or_create_by!(article: article, tag: tag)
  end
end

puts "Created #{Tag.count} tags"
puts "Created #{Article.count} articles"
