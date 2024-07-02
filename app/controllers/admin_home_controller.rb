class AdminHomeController < ApplicationController
  def page
	if session[:admin] == nil
	redirect_to admin_login_path

   end
  end

  def get_full
  admin = session[:admin]
   if admin.nil?
      render json: { code: 1, msg: "Chưa login admin" }
      return
    end
current_month_start = Time.now.beginning_of_month
current_month_end = Time.now.end_of_month

# Lấy tất cả các ví có wallet_type là "USD"
usd_wallet_ids = Wallet.where(wallet_type: "USD").pluck(:id)


# Tính tổng số tiền nạp
total_deposit = Deposit.where(wallet_id: usd_wallet_ids, status: ["Paid", "Over Paid"])
                       .where(created_at: current_month_start..current_month_end)
                       .sum(:amount)

# Tính tổng số tiền cược
total_bet = HistoryWallet.where(wallet_id: usd_wallet_ids)
                         .where(created_at: current_month_start..current_month_end)
                         .sum(:money_buy)

# Tính tổng phần thưởng
total_reward = HistoryWallet.where(wallet_id: usd_wallet_ids)
                            .where(created_at: current_month_start..current_month_end)
                            .sum(:reward)

# Tính tổng số tiền rút
total_withdraw = Withdraw.where(wallet_id: usd_wallet_ids, status: ["Success"])
                         .where(created_at: current_month_start..current_month_end)
                         .sum(:amount)

# Tính tổng số dư
total_balance = Wallet.where(wallet_type: "USD").sum(:balance)

# Tính lợi nhuận tổng
total_profit = total_deposit - (total_withdraw + total_balance)

# Trả về kết quả dưới dạng JSON
render json: {
  code: 0,
  msg: "Thành công",
  total_deposit: total_deposit,
  total_withdraw: total_withdraw,
  total_bet: total_bet,
  total_profit: total_profit,
}
  
  end

  def searching_time
  end
end
