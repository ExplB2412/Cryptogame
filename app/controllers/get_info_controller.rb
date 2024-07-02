class GetInfoController < ApplicationController
  def info_user
    user = User.find_by(id: session[:user_id])
    wallet = Wallet.find_by(id: session[:wallet_id])

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
    render json: { code: 0, msg: "Thành công", total_deposit: total_deposit, total_withdraw: total_withdraw, total_bet: total_bet, total_profit: total_profit, data: history_wallets }
  end
end