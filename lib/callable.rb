module Callable
  def call(*args)
    new(*args).call
  end
end
