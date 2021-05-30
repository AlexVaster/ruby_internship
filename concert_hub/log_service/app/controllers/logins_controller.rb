class LoginsController < ApplicationController
  def show; end

  def create
    LoginService.new(params, session).call
    redirect_to :login
  end

  def destroy
    session.delete(:login)
    redirect_to :login
  end
end
