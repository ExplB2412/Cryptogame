class WithdrawController < ApplicationController
   require 'bitcoin'
  def page
  
   if session[:user_id].nil?
    redirect_to new_login_path
  end
  
  end

   def with_request
    user = User.find_by(id: session[:user_id])
    wallet = Wallet.find_by(id: session[:wallet_id])

    if user.nil? || wallet.nil?
      render json: { code: 1, msg: "Người dùng hoặc ví không tồn tại" }
      return
    end

    amount = params[:amount].to_f
    wallet_address1 = params[:wallet_address1]
    wallet_address2 = params[:wallet_address2]

    if wallet_address1 != wallet_address2
      render json: { code: 4, msg: "Địa chỉ ví không khớp" }
      return
    end

    unless valid_bitcoin_address?(wallet_address1)
      render json: { code: 5, msg: "Địa chỉ ví không hợp lệ" }
      return
    end

    if amount >= 0.0001 && amount <= wallet.balance
      # Thực hiện các bước tiếp theo để xử lý yêu cầu rút tiền
      withdraw = Withdraw.new(
        user_id: user.id,
        wallet_id: wallet.id,
        status: 'pending',
        withdraw_address: wallet_address1,
        amount: amount,
        note: ''
      )

      if withdraw.save
        # Giả sử bạn có logic để trừ số dư từ ví
        wallet.update(balance: wallet.balance - amount)
        render json: { code: 0, msg: "Yêu cầu rút tiền đã được gửi" }
      else
        render json: { code: 2, msg: "Lỗi khi lưu yêu cầu rút tiền", errors: withdraw.errors.full_messages }
      end
    else
      render json: { code: 3, msg: "Số tiền rút không hợp lệ" }
    end
  end




  def check
  user = User.find_by(id: session[:user_id])
    
    if user.nil?
      render json: { code: 1, msg: "Bạn cần đăng nhập để xem lịch sử nạp tiền." }, status: :unauthorized
      return
    end

    withdraw = Withdraw.where(user_id: user.id).order(created_at: :desc).limit(10)
    render json: withdraw
  
  
  
  end
  
  
  private
  
    def valid_bitcoin_address?(address)
    Bitcoin.valid_address?(address)
  end
  
  
end
