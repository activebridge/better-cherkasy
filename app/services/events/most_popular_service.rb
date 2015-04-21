class Events::MostPopularService < Events::BaseService
  def fetch
    duration = params[:duration] || 'week'
    @events.most_popular.for_last(1.send(duration)).limit(10)
  end

  def self.serializer
    EventSerializer
  end
end
