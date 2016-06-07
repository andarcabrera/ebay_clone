//= require jquery
//= require countdown

describe("Coundown", function() {


  describe("auction is on going", function() {
    beforeEach(function (){
      this.auctionEndTime = Date.now() + 237300000;
      fixture.set('<p id="auction_end_time">' + new Date(this.auctionEndTime) + '</p> <p id="days">days</p> </p>' +
          '<p id="hours">hours</p>' + '<p id="minutes">minutes</p>' + '<p id="seconds">seconds</p>' + '<button id="buy_now_button">' + '<p id="bid_now_form"></p>');
      this.trackingElements = {
        days: $("#days"),
        hours: $("#hours"),
        minutes: $("#minutes"),
        seconds: $("#seconds"),
        auction_end_time: $("#auction_end_time"),
        buy_now_button: $("#buy_now_button"),
        bid_now_form: $("#bid_now_form")
      };
      this.countdown = new Countdown(this.trackingElements);
      this.countdown.start();
    });

    it("updates countdown in the dom", function() {

      expect($("#days", fixture.el).text()).toBe("2");
      expect($("#hours", fixture.el).text()).toBe("17");
      expect($("#minutes", fixture.el).text()).toBe("54");
      expect($("#seconds", fixture.el).text()).toBe("59");
      expect($("#auction_end_time", fixture.el).text()).toEqual(new Date(this.auctionEndTime).toString());
    });

    it("does not hide the auction end time and buy now buttons", function() {

      expect($('#buy_now_button').is(':visible')).toBe(true);
      expect($('#bid_now_form').is(':visible')).toBe(true);
    });
  });

  describe("auction is closed", function() {
    beforeEach(function (){
      this.auctionEndTime = Date.now() - 237300000;
      fixture.set('<p id="auction_end_time">' + new Date(this.auctionEndTime) + '</p> <p id="days">days</p> </p>' +
          '<p id="hours">hours</p>' + '<p id="minutes">minutes</p>' + '<p id="seconds">seconds</p>' + '<button id="buy_now_button">' + '<p id="bid_now_form"></p>');
      this.trackingElements = {
        days: $("#days"),
        hours: $("#hours"),
        minutes: $("#minutes"),
        seconds: $("#seconds"),
        auction_end_time: $("#auction_end_time"),
        buy_now_button: $("#buy_now_button"),
        bid_now_form: $("#bid_now_form")
      };
      this.countdown = new Countdown(this.trackingElements);
      this.countdown.start();
    });

      it("updates countdown in the dom", function() {

        expect($("#days", fixture.el).text()).toBe("days");
        expect($("#hours", fixture.el).text()).toBe("hours");
        expect($("#minutes", fixture.el).text()).toBe("minutes");
        expect($("#seconds", fixture.el).text()).toBe("seconds");
        expect($("#auction_end_time", fixture.el).text()).toEqual("Auction for this item is closed");
    });

    it("hidethe auction end time and buy now buttons", function() {

      expect($('#buy_now_button').is(':hidden')).toBe(true);
      expect($('#bid_now_form').is(':hidden')).toBe(true);
    });
  });
});
