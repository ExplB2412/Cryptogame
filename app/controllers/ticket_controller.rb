class TicketController < ApplicationController
  def page
  if session[:user_id].nil?
    redirect_to new_login_path
  end
  end

  def get_ticket
  
  user = User.find_by(id: session[:user_id])
    if user.nil?
      render json: { code: 1, msg: "Bạn cần đăng nhập để xem tin nhắn." }, status: :unauthorized
      return
    end

    ticket_support = TicketSupport.where(user_id: user.id).order(created_at: :asc).limit(30)
    render json: ticket_support
  
  
  
  
  
  end

  def post_ticket
  
	user = User.find_by(id: session[:user_id])
	message = params[:message].to_s
	ticket_support = TicketSupport.new(
	user_id: user.id,
	sender: 1,
	content:message	
	)
	if ticket_support.save 
	render json: { code: 0, msg: "Đã gửi tin nhắn thành công", content: message }
	else
	render json: { code: 1, msg: "Không thành công." }
	end
	
  end
  
  
  
  
  
  
end
