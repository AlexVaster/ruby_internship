class LoginsController < ApplicationController
    def show
    end
  
    def create
        result = LoginService.new(params, session).call
        if result
            redirect_to :login, notice: result
        else
            redirect_to :login, notice: result
        end
    end
  
    def destroy
        session.delete(:login)
        redirect_to :login, notice: 'Вы вышли'
    end
  end
  