class Events::FiltersService < Events::BaseService
  def fetch
    @events.by_location(params).by_tag(params[:tag])
  end

  def self.serializer
    EventSerializer
  end
end
