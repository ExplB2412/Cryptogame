class AdminPaymentWithdrawController < ApplicationController
  def page
    if session[:admin] == nil
	redirect_to admin_login_path

   end
  end

  def view_withdraw
  if session[:admin].nil?
    render json: { code: 1, msg: "Chưa đăng nhập admin" }
    return
  end

  # Truy vấn tất cả các bản ghi Withdraw và lấy user_id từ các bản ghi đó
  withdraws = Withdraw.order(created_at: :desc)
  
  user_ids = withdraws.pluck(:user_id).map(&:to_i)  # Chuyển đổi user_id sang kiểu số nguyên
  wallet_ids = withdraws.pluck(:wallet_id).map(&:to_i)  # Lấy danh sách wallet_id

  # Truy vấn tất cả các user tương ứng với các user_id đã lấy được
  users = User.where(id: user_ids)
  wallets = Wallet.where(id: wallet_ids)  # Truy vấn tất cả các wallet tương ứng với wallet_ids đã lấy được

  # Tạo một hash để tra cứu username từ user_id
  user_hash = users.each_with_object({}) do |user, hash|
    hash[user.id] = user.username
  end

  # Tạo một hash để tra cứu wallet_type từ wallet_id
  wallet_hash = wallets.each_with_object({}) do |wallet, hash|
    hash[wallet.id] = wallet.wallet_type
  end

  # Kết hợp dữ liệu Withdraw với username và wallet_type tương ứng
  withdraw_data = withdraws.map do |withdraw|
    {
      id: withdraw.id,
      user_id: withdraw.user_id,
      username: user_hash[withdraw.user_id.to_i],  # Thêm username
      wallet_id: withdraw.wallet_id,
      wallet_type: wallet_hash[withdraw.wallet_id.to_i],  # Thêm wallet_type
      status: withdraw.status,
      withdraw_address: withdraw.withdraw_address,
      amount: withdraw.amount,
      note: withdraw.note,
      created_at: withdraw.created_at,
      updated_at: withdraw.updated_at
    }
  end

  render json: { code: 0, data: withdraw_data }
end


  def update_withdraw
  end

  def delete_withdraw
  end

  def edit_withdraw
  
   if session[:admin].nil?
    render json: { code: 1, msg: "Chưa đăng nhập admin" }
    return
  end
  note = params[:note]
  withdraw_id = params[:id]

  # Tìm bản ghi rút tiền có id tương ứng
  withdraw = Withdraw.find_by(id: withdraw_id)

  if withdraw.nil?
    render json: { code: 2, msg: "Rút tiền không tồn tại" }
    return
  end

  # Tìm ví liên quan đến rút tiền
  wallet = Wallet.find_by(id: withdraw.wallet_id)

  if wallet.nil?
    render json: { code: 4, msg: "Ví không tồn tại" }
    return
  end

  # Cập nhật trạng thái và ghi chú
  withdraw.status = params[:status]
  withdraw.note = note

  if withdraw.save
    render json: { code: 0, msg: "Cập nhật rút tiền thành công" }
  else
    render json: { code: 3, msg: "Cập nhật rút tiền thất bại" }
  end
  
  
  end

  def cancel_withdraw
  end

def view_detail
 if session[:admin].nil?
    render json: { code: 1, msg: "Chưa đăng nhập admin" }
    return
  end
  withdraw_id = params[:id]
 withdraw = Withdraw.find_by(id: withdraw_id)
 wallet = Wallet.find_by(id: withdraw.wallet_id)
 user = User.find_by(id: withdraw.user_id)
 
 
 render json: {id: withdraw.id,
      user_id: withdraw.user_id,
      username: user.username,  # Thêm username
      wallet_id: withdraw.wallet_id,
      wallet_type: wallet.wallet_type,  # Thêm wallet_type
      status: withdraw.status,
      withdraw_address: withdraw.withdraw_address,
      amount: withdraw.amount,
      note: withdraw.note,
      created_at: withdraw.created_at,
      updated_at: withdraw.updated_at
	  }

end

def accept_withdraw
  if session[:admin].nil?
    render json: { code: 1, msg: "Chưa đăng nhập admin" }
    return
  end

  note = params[:note]
  withdraw_id = params[:id]

  # Tìm bản ghi rút tiền có id tương ứng
  withdraw = Withdraw.find_by(id: withdraw_id)

  if withdraw.nil?
    render json: { code: 2, msg: "Rút tiền không tồn tại" }
    return
  end

  # Tìm ví liên quan đến rút tiền
  wallet = Wallet.find_by(id: withdraw.wallet_id)

  if wallet.nil?
    render json: { code: 4, msg: "Ví không tồn tại" }
    return
  end

  # Cập nhật trạng thái và ghi chú
  withdraw.status = "Success"
  withdraw.note = note

  if withdraw.save
    # Tạo bản ghi trong HistoryWallet
    HistoryWallet.create(
      wallet_id: wallet.id,
      content: 'Rút tiền',
      money_buy: withdraw.amount,
      reward: 0 # hoặc giá trị reward tương ứng
    )

    render json: { code: 0, msg: "Cập nhật rút tiền thành công" }
  else
    render json: { code: 3, msg: "Cập nhật rút tiền thất bại" }
  end
end




end
