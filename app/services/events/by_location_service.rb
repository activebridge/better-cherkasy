class Events::ByLocationService < Events::BaseService
  def fetch
    Event.by_location(params)
  end

  def self.serializer
    EventSerializer
  end
end
