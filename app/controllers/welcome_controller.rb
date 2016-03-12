class WelcomeController < ApplicationController
  def submit_email
    @email = params[:email]
    # make model
    id = 10
    session[:id] = 10
  end
  
  def submit_info
    # params[:sam_text_input]
    # params[:sam_text_area]
    # params[:sam_select]
    # params[:sam_checkbox_1]
    # params[:sam_checkbox_2]
    # params[:sam_checkbox_3]
    @params = params.merge({ session_id: session[:id] });
  end
end
