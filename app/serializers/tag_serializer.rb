class TagSerializer
  include JSONAPI::Serializer

  set_id :name
  attributes :name, :count
end
