class Events::LatestService < Events::BaseService
  def fetch
    @events.newest.limit(10)
  end

  def self.serializer
    EventSerializer
  end
end
