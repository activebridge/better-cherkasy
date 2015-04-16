class Events::MostActiveService < Events::BaseService
  def fetch
    Event.most_active.limit(10)
  end

  def self.serializer
    EventSerializer
  end
end
