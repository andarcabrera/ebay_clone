function Countdown(trackingElements) {
  this.trackingElements = trackingElements;
  this.auction_end_time = trackingElements.auction_end_time.text();

  this.ongoing = function(durationCalculator) {
    this.trackingElements.days.html(durationCalculator.days);
    this.trackingElements.hours.html(durationCalculator.hours);
    this.trackingElements.minutes.html(durationCalculator.minutes);
    this.trackingElements.seconds.html(durationCalculator.seconds);
  };

  this.onEnd = function(durationCalculator) {
    this.trackingElements.auction_end_time.html("Auction for this item is closed");
    this.trackingElements.buy_now_button.hide();
    this.trackingElements.bid_now_form.hide();
  };

  this.start = function() {
    calc = new DurationCalculator(this.auction_end_time);
    duration = calc.duration;
    if(duration >= 0){
      this.ongoing(calc);
      setTimeout(this.start.bind(this), 1000);
    } else {
      this.onEnd();
    }
  }
}

function DurationCalculator(auction_end_time) {
  this.auctionEndTime = new Date(auction_end_time);
  this.now = new Date();
  this.duration = (this.auctionEndTime.getTime() - this.now.getTime())/1000;
  this.days = Math.floor(this.duration/86400);
  this.hours = Math.floor((this.duration%86400)/3600);
  this.minutes = Math.floor((this.duration%86400)%3600/60);
  this.seconds = Math.floor(this.duration%60);
}
