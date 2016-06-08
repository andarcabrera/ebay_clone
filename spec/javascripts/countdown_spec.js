//= require jquery
//= require countdown

describe("Coundown", function() {
  describe("auction is on going", function() {
    beforeEach(function(){
      this.endTime = Date.now() + 237300000;
      fixture.set('<p id="end_time">' + new Date(this.endTime) + '</p>'
          + '<p id="days"></p>'
          + '<p id="hours"></p>'
          + '<p id="minutes"></p>'
          + '<p id="seconds"></p>'
          + '<p id="on-end-test">change on end</p>');

      this.domDays = document.getElementById("days");
      this.domHours = document.getElementById("hours");
      this.domMinutes = document.getElementById("minutes");
      this.domSeconds = document.getElementById("seconds");
      this.domEndTime = document.getElementById("end_time").innerHTML;
      this.domOnEnd = document.getElementById("on-end-test");

      this.trackingElements = {
        days: this.domDays,
        hours: this.domHours,
        minutes: this.domMinutes,
        seconds: this.domSeconds
      };

      this.countdown = new Countdown(this.domEndTime, this.trackingElements);
      this.countdown.onEnd(function() {
        document.getElementById("on-end-test").innerHTML = "it changed!";
      });
      this.countdown.start();
    });

    it("updates countdown in the dom", function() {

      expect(this.domDays.innerHTML).toBe("2");
      expect(this.domHours.innerHTML).toBe("17");
      expect(this.domMinutes.innerHTML).toBe("54");
      expect(this.domSeconds.innerHTML).toBe("59");
    });

    it("does not modify the on end DOM element", function() {

      expect(this.domOnEnd.innerHTML).toBe("change on end");
    });
  });

  describe("auction is closed", function() {
    beforeEach(function (){
      this.endTime = Date.now() - 237300000;
      fixture.set('<p id="end_time">' + new Date(this.endTime) + '</p>'
          + '<p id="days"></p>'
          + '<p id="hours"></p>'
          + '<p id="minutes"></p>'
          + '<p id="seconds"></p>'
          + '<p id="on-end-test">change on end</p>');

      this.domDays = document.getElementById("days");
      this.domHours = document.getElementById("hours");
      this.domMinutes = document.getElementById("minutes");
      this.domSeconds = document.getElementById("seconds");
      this.domEndTime = document.getElementById("end_time").innerHTML;
      this.domOnEnd = document.getElementById("on-end-test");

      this.trackingElements = {
        days: this.domDays,
        hours: this.domHours,
        minutes: this.domMinutes,
        seconds: this.domSeconds
      };

      this.countdown = new Countdown(this.domEndTime, this.trackingElements);
      this.countdown.onEnd(function() {
        document.getElementById("on-end-test").innerHTML = "it changed!";
      });
      this.countdown.start();

    });

    it("updates the dom with end of event notice", function() {

      expect(this.domDays.innerHTML).toBe("");
      expect(this.domHours.innerHTML).toBe("");
      expect(this.domMinutes.innerHTML).toBe("");
      expect(this.domSeconds.innerHTML).toBe("");
      expect(this.domOnEnd.innerHTML).toBe("it changed!");
    });
  });
});
