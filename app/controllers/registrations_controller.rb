class RegistrationsController < ApplicationController
  def new
    render layout: false
  end

 def create
  username = params[:username]
  password = params[:password]
  password_confirmation = params[:password_confirmation]
  wallet_type = params[:wallet_type]
  client_ip = request.remote_ip
	securitykey = generate_unique_security_key
  if password != password_confirmation
    flash[:alert] = "Nhập lại mật khẩu không trùng khớp."
    redirect_to new_registration_path
  elsif username.length < 6 || username.length > 14
    flash[:alert] = "Username phải có từ 6 đến 14 ký tự."
    redirect_to new_registration_path
  elsif password.length < 6 || password.length > 14
    flash[:alert] = "Password phải có từ 6 đến 14 ký tự."
    redirect_to new_registration_path
  elsif !["USD","VND"].include?(wallet_type)
    flash[:alert] = "Loại ví chỉ có thể là 'USD' hoặc 'VND'."
    redirect_to new_registration_path
  elsif User.exists?(username: username)
    flash[:alert] = "Username đã tồn tại."
    redirect_to new_registration_path
  else
    # Sử dụng transaction để đảm bảo cả hai tác vụ đều thành công trước khi thực hiện chuyển hướng
    User.transaction do
      @user = User.new(username: username, password: password, ip: client_ip, securitykey: securitykey)
      if @user.save
        user_id = @user.id
        @wallet = Wallet.new(user_id: user_id, balance: 0, wallet_type: wallet_type)
        if @wallet.save
          flash[:notice] = "Tài khoản và ví đã được tạo thành công! Vui lòng đăng nhập"
          redirect_to new_login_path
        else
          flash[:alert] = "Đã có lỗi xảy ra khi tạo ví. Vui lòng thử lại sau."
          redirect_to new_registration_path
          raise ActiveRecord::Rollback # Lăn lại giao dịch nếu có lỗi xảy ra
        end
      else
        flash[:alert] = "Đã có lỗi xảy ra khi tạo tài khoản. Vui lòng thử lại sau."
        redirect_to new_registration_path
      end
    end
  end
end



def generate_unique_security_key
  loop do
    # Tạo một security key mới sử dụng SecureRandom
    security_key = SecureRandom.hex(12) # Sử dụng hex với độ dài 12 ký tự (32 bytes)
    
    # Kiểm tra xem security key mới tạo có duy nhất không
    unless User.exists?(securitykey: security_key)
      return security_key # Trả về security key duy nhất nếu không trùng lặp trong cơ sở dữ liệu
    end
  end
end

end