function Horse(id, x, y, speedRight, speedDown, speedLeft, speedUp) {
    this.element = document.getElementById(id); // Phần tử HTML của con ngựa
    this.originX = x; // Vị trí X ban đầu
    this.originY = y; // Vị trí Y ban đầu
    this.x = x; // Vị trí X hiện tại
    this.y = y; // Vị trí Y hiện tại
    this.number = parseInt(id.replace(/[\D]/g, '')); // Số của con ngựa
    this.lap = 0; // Vòng hiện tại của con ngựa
    this.totalTime = 0; // Tổng thời gian di chuyển của ngựa

    this.speedRight = speedRight;
    this.speedDown = speedDown;
    this.speedLeft = speedLeft;
    this.speedUp = speedUp;

    this.moveRight = function() {
        var horse = this;
        setTimeout(function() {
            horse.x++;
            horse.element.style.left = horse.x + 'vw';
            horse.totalTime += 1000 / horse.speedRight;

            if (horse.lap == num_lap && horse.x > horse.originX + 6) {
                horse.arrive();
            } else {
                if (horse.x < 82.5 - horse.number * 2.5) {
                    horse.moveRight();
                } else {
                    horse.element.className = 'horse runDown';
                    horse.moveDown();
                }
            }
        }, 1000 / this.speedRight);
    }

    this.moveDown = function() {
        var horse = this;
        setTimeout(function() {
            horse.y++;
            horse.element.style.top = horse.y + 'vh';
            horse.totalTime += 1000 / horse.speedDown;

            if (horse.y < horse.originY + 65) {
                horse.moveDown();
            } else {
                horse.element.className = 'horse runLeft';
                horse.moveLeft();
            }
        }, 1000 / this.speedDown);
    }

    this.moveLeft = function() {
        var horse = this;
        setTimeout(function() {
            horse.x--;
            horse.element.style.left = horse.x + 'vw';
            horse.totalTime += 1000 / horse.speedLeft;

            if (horse.x > 12.5 - horse.number * 2.5) {
                horse.moveLeft();
            } else {
                horse.element.className = 'horse runUp';
                horse.moveUp();
            }
        }, 1000 / this.speedLeft);
    }

    this.moveUp = function() {
        var horse = this;
        setTimeout(function() {
            horse.y--;
            horse.element.style.top = horse.y + 'vh';
            horse.totalTime += 1000 / horse.speedUp;

            if (horse.y > horse.originY) {
                horse.moveUp();
            } else {
                horse.element.className = 'horse runRight';
                horse.lap++;
                horse.moveRight();
            }
        }, 1000 / this.speedUp);
    }

    this.run = function() {
        this.element.className = 'horse runRight';
        this.moveRight();
    }

    this.arrive = function() {
        this.element.className = 'horse standRight';
        this.lap = 0;
        
        var tds = document.querySelectorAll('#results .result');
        tds[results.length].className = 'result horse' + this.number;
        results.push(this);

        if (results.length == 4) {
            results.sort(function(a, b) { return a.totalTime - b.totalTime; });

  var xhr = new XMLHttpRequest();
  xhr.open("GET", "/user/get_info", true);
  xhr.onload = function () {
    if (xhr.status >= 200 && xhr.status < 300) {
      var responseData = JSON.parse(xhr.responseText);
      document.getElementById('funds').innerText  = responseData.balance;
    } else {
      console.error('Request failed with status:', xhr.status);
    }
  };
  xhr.onerror = function () {
    console.error('Request failed');
  };
  xhr.send();
            document.getElementById('start').disabled = false;
        }
		
		
		
		
		
    }
}

var num_lap = 1, results = [], bethorse, amount;

document.addEventListener("DOMContentLoaded", function(event) {
    var horse1, horse2, horse3, horse4;

    document.getElementById('start').onclick = function() {
        amount = parseFloat(document.getElementById('amount').value);

        if (amount <= 0) {
            alert('Vui lòng nhập số tiền cược dương.');
            return;
        }

        if (isNaN(amount)) {
            alert('Vui lòng nhập số tiền cược hợp lệ.');
            return;
        }

        num_lap = 1;
        bethorse = parseInt(document.getElementById('bethorse').value);

        if (funds < amount) {
            alert('Không đủ tiền.');
        } else if (num_lap <= 0) {
            alert('Số vòng phải lớn hơn 0.');
        } else {
            this.disabled = true;
            var tds = document.querySelectorAll('#results .result');
            for (var i = 0; i < tds.length; i++) {
                tds[i].className = 'result';
            }

            $.ajaxSetup({
                headers: {
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                }
            });

            $.ajax({
                url: '/horseracing/bet',
                method: 'POST',
                data: {
                    money: amount,
                    horse_buy: bethorse
                },
                success: function(response) {
                    if (response.code === 0) {
                        let speed1 = response.speed1.split(' ');
                        let speed2 = response.speed2.split(' ');
                        let speed3 = response.speed3.split(' ');
                        let speed4 = response.speed4.split(' ');

                        horse1 = new Horse('horse1', 20, 4, parseFloat(speed1[0]), parseFloat(speed1[1]), parseFloat(speed1[2]), parseFloat(speed1[3]));
                        horse2 = new Horse('horse2', 20, 8, parseFloat(speed2[0]), parseFloat(speed2[1]), parseFloat(speed2[2]), parseFloat(speed2[3]));
                        horse3 = new Horse('horse3', 20, 12, parseFloat(speed3[0]), parseFloat(speed3[1]), parseFloat(speed3[2]), parseFloat(speed3[3]));
                        horse4 = new Horse('horse4', 20, 16, parseFloat(speed4[0]), parseFloat(speed4[1]), parseFloat(speed4[2]), parseFloat(speed4[3]));

                        results = [];
                        horse1.run();
                        horse2.run();
                        horse3.run();
                        horse4.run();
                    } else {
                        alert(response.msg);
                        document.getElementById('start').disabled = false;
                    }
                },
                error: function(xhr, status, error) {
                    alert('Có lỗi xảy ra: ' + error);
                    document.getElementById('start').disabled = false;
                }
            });
        }
    }
});
