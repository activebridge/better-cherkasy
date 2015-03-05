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
        self.status = :failuer
        self.result = user.errors.messages
      end
    end
    self
  end

  private

  def on_success
    access_token = user.authenticate!
    self.status = :success
    self.result = {
      token: access_token.token, user_id: user.id,
      name: user.name, avatar_url: user.avatar_url
    }
  end
end
