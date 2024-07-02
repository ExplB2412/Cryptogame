class UserController < ApplicationController
  def get_info
  
  if session[:user_id] == nil
  redirect_to root_path
  else
  user = User.find_by(id: session[:user_id])
  wallet = Wallet.find_by(id: session[:wallet_id])
  user_info = {
      username: user.username,
      balance: wallet.balance.round(10),
	  wallet: wallet.wallet_type
    }
	render json: user_info
  end
  end
end
