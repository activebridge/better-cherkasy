OAuth = Struct.new(:params, :status, :result, :user) do
  extend Callable

  def call
    self.user = User.find_by_provider_and_providerid(params[:provider], params[:providerid])
    if user
      on_success
    else
      self.user = User.create(params)
      if user.valid?
        on_success
      else
        self.status = :fail
        self.result = user.errors.messages
      end
    end
    self
  end

  private

  def on_success
    self.result = {auth_token: user.authenticate!, status: :ok}
  end
end
