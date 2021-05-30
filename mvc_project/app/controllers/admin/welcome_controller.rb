class Admin::WelcomeController < ApplicationController
  def index
    render plain: "Hello Admin!"
  end
end
