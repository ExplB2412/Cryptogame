class AdminUserController < ApplicationController
  def page
  if session[:admin] == nil
	redirect_to admin_login_path

   end
  end

  def view_user
  if session[:admin].nil?
    render json: { code: 1, msg: "Chưa login admin" }
    return
  end

  # Lấy tất cả user và sắp xếp theo created_at giảm dần
  users = User.order(created_at: :desc)
  user_data = users.map do |user|
    wallet = Wallet.find_by(user_id: user.id)  # Lấy ví theo user_id
    
    # Lấy tổng nạp với status là "Paid" hoặc "Over Paid"
    total_deposit = Deposit.where(user_id: user.id, status: ['Paid', 'Over Paid']).sum(:amount)
    
    # Lấy tổng rút với status là "Success"
    total_withdraw = Withdraw.where(user_id: user.id, status: 'Success').sum(:amount)
    
    # Lấy tổng rút đang chờ với status là "pending" hoặc "Pending"
    pending_withdraw = Withdraw.where(user_id: user.id, status: ['pending', 'Pending']).sum(:amount)

    {
      user_id: user.id,
      username: user.username,
      balance: wallet ? wallet.balance.to_s + " " + wallet.wallet_type : "No wallet", # Ghép balance với wallet_type
      create_time: user.created_at,
      total_deposit: total_deposit,
      total_withdraw: total_withdraw,
      pending_withdraw: pending_withdraw
    }
  end

  render json: { code: 0, data: user_data }
end


  def edit_user
  end

 def post_edit_user
  if session[:admin].nil?
    render json: { code: 1, msg: "Chưa login admin" }
    return
  end

  user_name = params[:username]
  if user_name.nil? || user_name.strip.empty?
    render json: { code: 1, msg: "Tên người dùng không hợp lệ" }
    return
  end

  users = User.where("username LIKE ?", "%#{user_name}%")
  if users.empty?
    render json: { code: 1, msg: "User không tồn tại" }
    return
  end

  data = users.map do |user|
    wallet = Wallet.find_by(user_id: user.id)
    total_deposit = Deposit.where(user_id: user.id, status: ['Paid', 'Over Paid']).sum(:amount)
    total_withdraw = Withdraw.where(user_id: user.id, status: 'Success').sum(:amount)
    pending_withdraw = Withdraw.where(user_id: user.id, status: ['pending', 'Pending']).sum(:amount)

    {
      user_id: user.id,
      username: user.username,
      balance: wallet ? "#{wallet.balance} #{wallet.wallet_type}" : "No wallet",
      create_time: user.created_at,
      total_deposit: total_deposit,
      total_withdraw: total_withdraw,
      pending_withdraw: pending_withdraw
    }
  end

  render json: { code: 0, data: data }
end

end
