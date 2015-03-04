OAuth = Struct.new(:params, :status, :result, :user) do
  extend Callable

  def call
    self.user = User.find_by_provider_and_providerid(params[:provider], params[:providerid])
    if user
      self.status = :success
      self.result = api_data
    else
      self.user = User.create(params)
      if user.valid?
        self.status = :success
        self.result = api_data
      else
        self.status = :failuer
        self.result = user.errors.messages
      end
    end
    self
  end

  private

  def api_data
    {
      token: user.token, user_id: user.providerid,
      name: user.name, avatar_url: user.avatar_url
    }
  end
end
