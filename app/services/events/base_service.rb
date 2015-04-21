class Events::BaseService
  attr_accessor :params

  def initialize(params)
    @params = params
    @events = Event.send(params[:scope] || Event::STATUS[:pending])
  end
end
