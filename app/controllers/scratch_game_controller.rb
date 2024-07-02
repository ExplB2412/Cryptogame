class ScratchGameController < ApplicationController
  def page
  if session[:user_id].nil?
    redirect_to new_login_path
  end
end
  
  
  
  

  def scratch
   if session[:user_id].nil?
    redirect_to new_login_path
  else
    user = User.find_by(id: session[:user_id])
    existing_scratch = ScratchGame.find_by(user_id: user.id, status: 'new')
	wallet = Wallet.find_by(user_id: user.id)
    if existing_scratch
		kq = existing_scratch.reward * existing_scratch.price

      # Chỉnh status về 'scratched'
		existing_scratch.update(status: 'scratched')

      # Update lại balance của user
		new_balance = wallet.balance + kq
		wallet.update(balance: new_balance)

HistoryWallet.create(
wallet_id: wallet.id,
content: 'Thẻ cào sổ xố',
money_buy: existing_scratch.price,
reward: kq
)
    end
  
  end
  render json: { kq: kq, new_balance: new_balance}
  end
  
  
  def result
  
   user = User.find_by(id: session[:user_id])
    
    if user.nil?
      render json: { code: 1, msg: "Bạn cần đăng nhập để xem lịch sử trò chơi." }, status: :unauthorized
      return
    end

    scratch = ScratchGame.where(user_id: user.id).order(created_at: :desc).limit(10)
    render json: scratch
	
  end
  
  
  
  def buy
  if session[:user_id].nil?
    redirect_to root_path
  else
    user = User.find_by(id: session[:user_id])
    wallet = Wallet.find_by(id: session[:wallet_id])
    
    # Check if user and wallet exist
    unless user && wallet
      render json: { code: 1, msg: "User or Wallet not found" }
      return
    end
    
    user_balance = wallet.balance

    begin
      money_buy = Float(params[:money])
    rescue ArgumentError, TypeError
      render json: { code: 1, msg: "Số tiền mua không hợp lệ" }
      return
    end

    if money_buy <= 0
      render json: { code: 1, msg: "Số tiền mua phải lớn hơn 0" }
      return
    elsif user_balance < money_buy
      render json: { code: 1, msg: "Số dư không đủ để mua thẻ cào" }
      return
    end

    existing_scratch = ScratchGame.find_by(user_id: user.id, status: 'new')
    if existing_scratch
      render json: { code: 2, msg: "Vẫn còn thẻ cào đang chờ xử lý", scratch_id: existing_scratch.id, reward: existing_scratch.reward }
      return
    end

    # Tạo phần thưởng với tỷ lệ mong muốn
    prize = generate_prize

    @scratch = ScratchGame.new(reward: prize, user_id: user.id, price: money_buy, status: "new")

    if @scratch.save
      wallet.update(balance: user_balance - money_buy)
      render json: { code: 0, msg: "Thẻ cào mới đã được tạo thành công.", scratch_id: @scratch.id, reward: @scratch.reward }
    else
      render json: { code: 1, msg: "Có lỗi xảy ra trong quá trình lưu trò chơi cào thẻ." }
    end
  end
end

private

def generate_prize
  probabilities = {
    888.88 => 1,
    88.88 => 2,
    8.88 => 5,
    0.88 => 40,
    0 => 52
  }

  total = 100
  random = rand(total)

  cumulative = 0
  probabilities.each do |prize, probability|
    cumulative += probability
    return prize if random < cumulative
  end
end


end
