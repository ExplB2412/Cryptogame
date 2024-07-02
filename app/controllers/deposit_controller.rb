require 'uri'
require 'net/http'
require 'rest-client'
class DepositController < ApplicationController

skip_before_action :verify_authenticity_token, only: [:notify]

 def page
  if session[:user_id].nil?
    redirect_to new_login_path
  end
  end

   def notify
    invoice_id = params[:invoice_id]
    status = params[:status]
    paid_amount = params[:paid_amount].to_f

    deposit = Deposit.find_by(invoice: invoice_id)

    if deposit
      deposit.update(status: status)

      if status == "Paid" || status == "Over Paid"
        wallet = Wallet.find_by(id: deposit.wallet_id)
        balance = wallet.balance + deposit.amount
        wallet.update(balance: balance)
      end

      render json: { code: 0, msg: "Cập nhật thông tin hóa đơn thành công" }
    else
      render json: { code: 1, msg: "Không tìm thấy hóa đơn" }
    end
  rescue StandardError => e
    render json: { code: 2, msg: "Lỗi không xác định", error: e.message }
  end



  def success
  end

  def fails
  end

def check
    user = User.find_by(id: session[:user_id])
    
    if user.nil?
      render json: { code: 1, msg: "Bạn cần đăng nhập để xem lịch sử nạp tiền." }, status: :unauthorized
      return
    end

    deposits = Deposit.where(user_id: user.id).order(created_at: :desc).limit(10)
    render json: deposits
  end




   def deposit
  user = User.find_by(id: session[:user_id])
  wallet = Wallet.find_by(id: session[:wallet_id])

  if user.nil? || wallet.nil?
    render json: { code: 1, msg: "Người dùng hoặc ví không tồn tại" }
    return
  end

  amount = params[:amount].to_s

  begin
    url = URI("https://coinremitter.com/api/v3/BTC/create-invoice")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "multipart/form-data"
    form_data = [
      ['api_key', '$2b$10$draANsHqmUclADFRf3atIeF6CY7Bvp4ZNnANHikkSMTVadpkI/266'],
      ['password', 'BaBinh2412'],
      ['amount', amount],
      ['name', 'TopupPayment'],
      ['currency', 'USD'],
      ['expire_time', '30'],
      ['notify_url', 'http://36.50.232.24:3000/deposit/notify'],
      ['success_url', 'http://36.50.232.24:3000/deposit'],
      ['fail_url', 'http://36.50.232.24:3000/deposit'],
      ['description', 'Topup'],
      ['custom_data1', 'Topup'],
      ['custom_data2', 'Toptop']
    ]
    request.set_form form_data, 'multipart/form-data'

    response = https.request(request)
    response_body = JSON.parse(response.body)

    if response_body["flag"] == 1  # Assuming flag indicates success
      address_wallet = response_body["data"]["address"]
      amount_pay = response_body["data"]["total_amount"]["BTC"]
      invoice = response_body["data"]["invoice_id"]
      
      Deposit.create(
        user_id: user.id,
        wallet_id: wallet.id,
        status: 'pending',
        deposit_address: address_wallet,
        invoice: invoice,
        amount: amount
      )

      render json: { code: 0, msg: "Hóa đơn tạo thành công", data: { address: address_wallet, amount: amount_pay } }
    else
      render json: { code: 2, msg: "Lỗi khi tạo hóa đơn", error: response_body["msg"] }
    end
  rescue StandardError => e
    render json: { code: 3, msg: "Lỗi không xác định", error: e.message }
  end
end
  
  
    private

  def log_params(params)
    File.open(Rails.root.join('log', 'deposit_notify.log'), 'a') do |file|
      file.puts("#{Time.now}: #{params.to_json}")
    end
  end
  
  
end
