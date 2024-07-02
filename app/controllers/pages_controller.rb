class PagesController < ApplicationController
  def home
  if session[:user_id] == nil
  redirect_to new_login_path
  end
  
  end
end
