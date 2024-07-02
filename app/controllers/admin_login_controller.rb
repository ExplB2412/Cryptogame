class AdminLoginController < ApplicationController
  def page
  render layout: false
  end

  def login
  admin_password = 'abcd1234'
  password = params[:password]
  if admin_password == password
	session[:admin] = 'admin'
	redirect_to admin_path
	else
	flash[:alert] = "Tên đăng nhập hoặc mật khẩu không đúng."
    redirect_to admin_login_path
	end
  end

  def destroy
  session[:admin] = nil
  redirect_to admin_path
  end
end
