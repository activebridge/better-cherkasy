class EventSerializer < ActiveModel::Serializer
  attributes :id, :headline, :description, :rating
end
