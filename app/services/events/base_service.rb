class Events::BaseService
  attr_accessor :params

  def initialize(params)
    @params = params
  end
end
