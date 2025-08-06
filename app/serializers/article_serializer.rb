class ArticleSerializer
  include JSONAPI::Serializer

  set_id :slug
  attributes :title, :content, :published_at, :created_at, :updated_at
  attribute :tags
  attribute :normalized_tags

  def normalized_tags
    object.normalized_tags.pluck(:name)
  end
end
