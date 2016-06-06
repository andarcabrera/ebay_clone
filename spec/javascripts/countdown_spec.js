//= require jquery
//= require countdown

describe("Using fixtures", function() {
  describe("auction is on going", function() {
    var auctionEndTime = Date.now() + 237300000;
    fixture.set('<p id="auction_end_time">' + new Date(auctionEndTime) + '</p> <p id="days">days</p> </p>' +
        '<p id="hours">hours</p>' + '<p id="minutes">minutes</p>' + '<p id="seconds">seconds</p>' + '<button id="buy_now_button">' + '<p id="bid_now_form"></p>');

    it("updates countdown in the dom", function() {
      updateCountdown();
      expect($("#days", fixture.el).text()).toBe("2");
      expect($("#hours", fixture.el).text()).toBe("17");
      expect($("#minutes", fixture.el).text()).toBe("54");
      expect($("#seconds", fixture.el).text()).toBe("59");
      expect($("#auction_end_time", fixture.el).text()).toEqual(new Date(auctionEndTime).toString());
    });

    it("does not hide the auction end time and buy now buttons", function() {
      updateCountdown();
      expect($('#buy_now_button').is(':visible')).toBe(true);
      expect($('#bid_now_form').is(':visible')).toBe(true);
    });
  });

  describe("auction is closed", function() {
    var auctionEndTime = Date.now() - 237300000;
    fixture.set('<p id="auction_end_time">' + new Date(auctionEndTime) + '</p> <p id="days">days</p> </p>' +
        '<p id="hours">hours</p>' + '<p id="minutes">minutes</p>' + '<p id="seconds">seconds</p>' + '<button id="buy_now_button">' + '<p id="bid_now_form"></p>');

    it("updates countdown in the dom", function() {
      updateCountdown();
      expect($("#days", fixture.el).text()).toBe("days");
      expect($("#hours", fixture.el).text()).toBe("hours");
      expect($("#minutes", fixture.el).text()).toBe("minutes");
      expect($("#seconds", fixture.el).text()).toBe("seconds");
      expect($("#auction_end_time", fixture.el).text()).toEqual("Auction for this item is closed");
    });

    it("hidethe auction end time and buy now buttons", function() {
      updateCountdown();
      expect($('#buy_now_button').is(':hidden')).toBe(true);
      expect($('#bid_now_form').is(':hidden')).toBe(true);
    });
  });
});
