class WelcomeController < ApplicationController
  def submit_email
    @email = params[:email]
  end
end
