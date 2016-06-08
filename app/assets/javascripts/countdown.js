function Countdown(endTime, trackingElements) {
  this.trackingElements = trackingElements;
  this.endTime = new Date(endTime).getTime();
  this.onEndCallBack = function() {};
}

Countdown.prototype.days = function(duration) {
  return Math.floor(duration/86400);
};

Countdown.prototype.hours = function(duration) {
  return Math.floor((duration%86400)/3600);
};

Countdown.prototype.minutes = function(duration) {
  return Math.floor((duration%86400)%3600/60);
};

Countdown.prototype.seconds = function(duration) {
  return Math.floor(duration%60);
};

Countdown.prototype.start = function() {
  var duration = (this.endTime - (new Date()).getTime())/1000;
  if(duration >= 0){
    this.updateElements(duration);
    setTimeout(this.start.bind(this), 1000);
  } else {
    this.onEndCallBack();
  }
}

Countdown.prototype.updateElements = function(duration) {
  this.trackingElements.days.innerHTML = this.days(duration);
  this.trackingElements.hours.innerHTML = this.hours(duration);
  this.trackingElements.minutes.innerHTML = this.minutes(duration);
  this.trackingElements.seconds.innerHTML = this.seconds(duration);
};

Countdown.prototype.onEnd = function(callback) {
  this.onEndCallBack = callback;
}
