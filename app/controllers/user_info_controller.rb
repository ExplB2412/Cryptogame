class UserInfoController < ApplicationController
  def page
   if session[:user_id].nil?
    redirect_to new_login_path
  end
  end

 def change_password
  user = User.find_by(id: session[:user_id])
  if user.nil?
    render json: { code: 1, msg: "Người dùng không tồn tại" }
    return
  end

  password = params[:password]
  password_1 = params[:password_1]
  password_2 = params[:password_2]

  if password == user.password
    if password_1.length < 6 || password_1.length > 14
      render json: { code: 4, msg: "Mật khẩu phải từ 6 đến 14 ký tự" }
      return
    elsif password_1 != password_2
      render json: { code: 5, msg: "Mật khẩu mới không khớp" }
      return
    else
      user.password = password_1
      if user.save
        render json: { code: 0, msg: "Đổi mật khẩu thành công" }
      else
        render json: { code: 6, msg: "Có lỗi xảy ra, vui lòng thử lại" }
      end
    end
  else
    render json: { code: 3, msg: "Mật khẩu hiện tại không đúng" }
  end
end



end
