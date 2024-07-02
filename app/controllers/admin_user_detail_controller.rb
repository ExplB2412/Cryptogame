class AdminUserDetailController < ApplicationController
  def page
	if session[:admin] == nil
	redirect_to admin_login_path

   end
  
  end

  def view_user
  if session[:admin] == nil
	render json: { code: 1, msg: "Chưa đăng nhập admin" }
      return
   end
	user_id = params[:user_id]
	user = User.find_by(id: user_id)
    wallet = Wallet.find_by(user_id: user_id)

    if user.nil?
      render json: { code: 1, msg: "Người dùng không tồn tại" }
      return
    end

    current_month_start = Time.now.beginning_of_month
    current_month_end = Time.now.end_of_month

    # Lấy tất cả các bản ghi HistoryWallet của wallet_id trong tháng hiện tại và sắp xếp theo thời gian gần nhất
    history_wallets = HistoryWallet.where(wallet_id: wallet.id)
                                   .where(created_at: current_month_start..current_month_end)
                                   .order(created_at: :desc)

    total_deposit = Deposit.where(wallet_id: wallet.id, status: ["Paid", "Over Paid"])
                           .where(created_at: current_month_start..current_month_end)
                           .sum(:amount)
    total_bet = HistoryWallet.where(wallet_id: wallet.id).where(created_at: current_month_start..current_month_end).sum(:money_buy)
    total_reward = HistoryWallet.where(wallet_id: wallet.id).where(created_at: current_month_start..current_month_end).sum(:reward)
    
    total_withdraw = Withdraw.where(wallet_id: wallet.id, status: ["Success"]).where(created_at: current_month_start..current_month_end).sum(:amount)
	total_profit = total_withdraw + wallet.balance - total_deposit
    render json: { code: 0, msg: "Thành công", total_deposit: total_deposit, total_withdraw: total_withdraw, total_bet: total_bet, total_profit: total_profit, data: history_wallets, user: user, wallet: wallet }
  
  
  
  end

def edit_user
  if session[:admin].nil?
    render json: { code: 1, msg: "Chưa đăng nhập admin" }
    return
  end

  user_id = params[:user_id]
  new_balance = params[:new_balance]

  begin
    new_balance = Float(new_balance)
  rescue ArgumentError, TypeError
    render json: { code: 2, msg: "Giá trị số dư mới không hợp lệ" }
    return
  end

  user = User.find_by(id: user_id)
  if user.nil?
    render json: { code: 1, msg: "Người dùng không tồn tại" }
    return
  end

  wallet = Wallet.find_by(user_id: user_id)
  wallet.balance += new_balance
HistoryWallet.create(
wallet_id: wallet.id,
content: 'Admin cập nhật số dư',
money_buy: 0,
reward: new_balance
)
  if wallet.save
    render json: { code: 0, msg: "Cập nhật số dư thành công" }
  else
    render json: { code: 6, msg: "Có lỗi xảy ra, vui lòng thử lại" }
  end
  

end

  def post_edit_user
  if session[:admin] == nil
	render json: { code: 1, msg: "Chưa đăng nhập admin" }
      return
   end
   user_id = params[:user_id]
	user = User.find_by(id: user_id)
  if user.nil?
    render json: { code: 1, msg: "Người dùng không tồn tại" }
    return
  end

  password = params[:password]
 user.password = password
if user.save
        render json: { code: 0, msg: "Đổi mật khẩu thành công" }
      else
        render json: { code: 6, msg: "Có lỗi xảy ra, vui lòng thử lại" }
      end
   
  
  
  end
end
