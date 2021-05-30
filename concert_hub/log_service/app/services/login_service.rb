class LoginService
  attr_reader :login, :password, :session

  def initialize(params, session)
    @login = params[:login]
    @password = params[:password]
    @session = session
  end

  def call
    verify_user
    modify_session
  end

  def self.check_authorization(session)
    raise Error::NotAuthorized unless session[:login]
  end

  private

  def verify_user
    raise Error::NotAuthenticate if @login != 'admin' || @password != 'admin'
  end

  def modify_session
    session[:login] = @login
  end
end
