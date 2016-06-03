$(document).ready(function() {
  updateCountdown();
  setInterval(updateCountdown, 1000);

  function updateCountdown() {
    var days, hours, minutes, seconds, now, auctionEndTime;

    var auctionEndTimeText = $("#auction_end_time").text();
    auctionEndTime = new Date(auctionEndTimeText)

    now = new Date();
    var duration = (auctionEndTime.getTime() - now.getTime())/1000;

    days = Math.floor(duration/86400);
    hours = Math.floor((duration%86400)/3600);
    minutes = Math.floor((duration%86400)%3600/60);
    seconds = Math.floor(duration%60);

    if (duration <= 0) {
      $("#auction_end_time").html("Auction for this items is closed");
    } else {
      $("#days").html(days);
      $("#hours").html(hours);
      $("#minutes").html(minutes);
      $("#seconds").html(seconds);
    }
  }
});