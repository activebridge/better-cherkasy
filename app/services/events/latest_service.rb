class Events::LatestService < Events::BaseService
  def fetch
    Event.newest.limit(10)
  end

  def self.serializer
    EventSerializer
  end
end
