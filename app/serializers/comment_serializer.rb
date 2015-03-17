class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created, :ancestors_count

  has_one :user
  has_one :parent

  def created
    object.created_at.strftime('%d %B %Y об %I:%M %p')
  end

  def ancestors_count
    object.ancestors.count
  end
end
