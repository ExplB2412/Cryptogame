class AdminPaymentDepositController < ApplicationController
  def page
  if session[:admin] == nil
	redirect_to admin_login_path

   end
  end

def view_deposit
  if session[:admin].nil?
    render json: { code: 1, msg: "Chưa đăng nhập admin" }
    return
  end

  # Truy vấn tất cả các bản ghi Deposit và lấy user_id từ các bản ghi đó
  deposits = Deposit.order(created_at: :desc)
  user_ids = deposits.pluck(:user_id).map(&:to_i)  # Chuyển đổi user_id sang kiểu số nguyên
  wallet_ids = deposits.pluck(:wallet_id).map(&:to_i)  # Lấy danh sách wallet_id

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

  # Kết hợp dữ liệu Deposit với username và wallet_type tương ứng
  deposit_data = deposits.map do |deposit|
    {
      id: deposit.id,
      user_id: deposit.user_id,
      username: user_hash[deposit.user_id.to_i],  # Chuyển user_id sang kiểu số nguyên để tra cứu
      wallet_id: deposit.wallet_id,
      wallet_type: wallet_hash[deposit.wallet_id.to_i],  # Chuyển wallet_id sang kiểu số nguyên để tra cứu
      status: deposit.status,
      deposit_address: deposit.deposit_address,
      invoice: deposit.invoice,
      amount: deposit.amount,
      created_at: deposit.created_at,
      updated_at: deposit.updated_at
    }
  end

  render json: { code: 0, data: deposit_data }
end

  

  def update_deposit
  end

  def delete_deposit
  end

  def edit_deposit
  end

  def cancel_deposit
  end
end
