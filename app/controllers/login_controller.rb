class LoginController < ApplicationController
  def new
  render layout: false
  end

  def create
  username = params[:username]
  password = params[:password]
  if User.exists?(username: username)
  user = User.find_by(username: username)
  password_check = user.password
  
    if password == password_check
      session[:user_id] = user.id
	  wallet = Wallet.find_by(user_id: user.id)
	  session[:wallet_id] = wallet.id
      redirect_to root_path
    else
      flash[:alert] = "Tên đăng nhập hoặc mật khẩu không đúng."
      redirect_to new_login_path
    end
	else 
		flash[:alert] = "Tên đăng nhập hoặc mật khẩu không đúng."
      redirect_to new_login_path
	
	end
	
  end

  def destroy
  session[:user_id] = nil
  session[:wallet_id] = nil
  redirect_to root_path
  end
end
