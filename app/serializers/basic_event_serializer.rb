class BasicEventSerializer < ActiveModel::Serializer
  attributes :id, :headline, :description,
    :date, :time, :address, :lat, :lng

  has_many :tags

  def date
    object.date.strftime('%d-%m-%Y') if object.date
  end

  def time
    object.time.strftime('%I:%M %p') if object.time
  end
end
