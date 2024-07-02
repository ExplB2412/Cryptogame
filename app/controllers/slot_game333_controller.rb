class SlotGame333Controller < ApplicationController
  def page
  if session[:user_id].nil?
    redirect_to new_login_path
  end
  end

 def spin
  user = User.find_by(id: session[:user_id])
  wallet = Wallet.find_by(id: session[:wallet_id])
  
  if user.nil? || wallet.nil?
    render json: { code: 1, msg: "Người dùng hoặc ví không tồn tại" }
    return
  end

  user_balance = wallet.balance
  money_buy = params[:money].to_f

  if money_buy <= 0 || money_buy > user_balance
    render json: { code: 1, msg: "Không đủ số dư / số dư không hợp lệ" }
    return
  end

  # Trừ số tiền mua từ số dư
  wallet.update(balance: user_balance - money_buy)

  # Tạo ba số ngẫu nhiên
  num1 = rand(1..3)
  num2 = rand(1..3)
  num3 = rand(1..3)

  if num1 == num2 && num2 == num3
    case num1
    when 1
      reward = money_buy * 0.88
    when 2
      reward = money_buy * 2.88
    when 3
      reward = money_buy * 4.88
    end
  else
    reward = 0
  end

  # Cộng phần thưởng vào số dư
  wallet.update(balance: wallet.balance + reward)
balance = wallet.balance
  @slotgame = SlotGame333.new(
    reward: reward, 
    user_id: user.id, 
    num1: num1, 
    num2: num2, 
    num3: num3, 
    price: money_buy, 
    status: "completed"
  )
	new_reward = reward.round(10)
	HistoryWallet.create(
wallet_id: wallet.id,
content: 'Slot Game 333',
money_buy: money_buy,
reward: reward
)

  if @slotgame.save
    code = 0
    msg = "Chúc mừng bạn đã trúng #{new_reward} #{wallet.wallet_type}"
  else
    code = 1
    msg = "Có lỗi xảy ra khi lưu kết quả"
  end

  render json: { code: code, msg: msg, num1: num1, num2: num2, num3: num3, reward: new_reward, balance: balance }
end

  def result
  
   user = User.find_by(id: session[:user_id])
    
    if user.nil?
      render json: { code: 1, msg: "Bạn cần đăng nhập để xem lịch sử trò chơi." }, status: :unauthorized
      return
    end

    slot_game333 = SlotGame333.where(user_id: user.id).order(created_at: :desc).limit(10)
    render json: slot_game333
  
  
  
  end
end
