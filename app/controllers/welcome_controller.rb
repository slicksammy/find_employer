class WelcomeController < ApplicationController
  def create
    @email = params[:email]
  end
end
