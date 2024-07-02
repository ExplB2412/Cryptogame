class HorseracingController < ApplicationController
  def page
  if session[:user_id].nil?
    redirect_to new_login_path
	else
  render layout: false
   
  end
end

def racing
  user = User.find_by(id: session[:user_id])
  wallet = Wallet.find_by(id: session[:wallet_id])

  if user.nil? || wallet.nil?
    render json: { code: 1, msg: "Người dùng hoặc ví không tồn tại" }
    return
  end

  user_balance = wallet.balance
  money_buy = params[:money].to_f
  horse_buy = params[:horse_buy].to_s

if !["1", "2", "3", "4"].include?(horse_buy)
  render json: { code: 1, msg: "Ngựa không hợp lệ" }
  return
end

  if money_buy <= 0.000001 || money_buy > user_balance
    render json: { code: 1, msg: "Không đủ số dư / số dư không hợp lệ" }
    return
  end

  # Trừ số tiền mua từ số dư
  wallet.update(balance: user_balance - money_buy)

  # Tạo các giá trị tốc độ ngẫu nhiên cho mỗi con ngựa
  sp11 = rand(10..20)
  sp12 = rand(10..20)
  sp13 = rand(10..20)
  sp14 = rand(10..20)
  sp21 = rand(10..20)
  sp22 = rand(10..20)
  sp23 = rand(10..20)
  sp24 = rand(10..20)
  sp31 = rand(10..20)
  sp32 = rand(10..20)
  sp33 = rand(10..20)
  sp34 = rand(10..20)
  sp41 = rand(10..20)
  sp42 = rand(10..20)
  sp43 = rand(10..20)
  sp44 = rand(10..20)

  # Tạo các chuỗi tốc độ tương ứng
  speed1 = "#{sp11} #{sp12} #{sp13} #{sp14}"
  speed2 = "#{sp21} #{sp22} #{sp23} #{sp24}"
  speed3 = "#{sp31} #{sp32} #{sp33} #{sp34}"
  speed4 = "#{sp41} #{sp42} #{sp43} #{sp44}"

  # Hàm tính tổng thời gian cho mỗi con ngựa
  def calculate_total_time(speed)
    speeds = speed.split.map(&:to_f)
    (82.5 - 20) / speeds[0] + 65 / speeds[1] + 70 / speeds[2] + 65 / speeds[3]
  end

  # Tính toán tổng thời gian cho mỗi con ngựa
  total_time1 = calculate_total_time(speed1)
  total_time2 = calculate_total_time(speed2)
  total_time3 = calculate_total_time(speed3)
  total_time4 = calculate_total_time(speed4)

  # Xác định kết quả cuộc đua
  times = { "1" => total_time1, "2" => total_time2, "3" => total_time3, "4" => total_time4 }
  sorted_times = times.sort_by { |_, time| time }
  top1, top2, top3, top4 = sorted_times.map { |horse, _| horse }

  # Xác định phần thưởng
  reward = if top1 == horse_buy
             money_buy * 3.88 # Ví dụ: gấp đôi số tiền cược nếu thắng
           else
             0
           end

  # Tạo một bản ghi HorseRacing mới
  Horseracing.create(
    user_id: user.id,
    horse_buy: horse_buy,
    top1: top1,
    top2: top2,
    top3: top3,
    top4: top4,
    speed1: speed1,
    speed2: speed2,
    speed3: speed3,
    speed4: speed4,
    status: "finished",
    price: money_buy,
    reward: reward
  )
  
HistoryWallet.create(
wallet_id: wallet.id,
content: 'Đua ngựa',
money_buy: money_buy,
reward: reward
)

  # Cập nhật số dư ví
  wallet.update(balance: wallet.balance + reward)

  # Trả về kết quả dưới dạng JSON
  render json: { code: 0, msg: "Đua ngựa thành công", top1: top1, top2: top2, top3: top3, top4: top4, speed1: speed1, speed2: speed2, speed3: speed3, speed4: speed4, reward: reward, balance: wallet.balance }
end

  def result
  end
end
