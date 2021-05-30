class LoginService
    attr_reader :login, :password, :session
  
    def initialize(params, session)
      @login, @password, @session = params[:login], params[:password], session
    end
  
    def call
      if check_password
        modify_session
        message
      else
        'Неверный пароль'
      end
    end
  
    private
  
    def check_password
      password == '123' ? true : false
    end
  
    def modify_session
        session[:balance] ||= 15000
        session[:login] = login 
    end
  
    def message
        notice_message = case Time.now.hour
        when 0..5
          'Доброй ночи, '
        when 6..11
          'С добрым утром, '
        when 12..17
          'Добрый день, '
        when 18..24
          'Добрый вечер, '
        else
          'Здравствуйте, '
        end + login

        notice_message
    end
  end
  