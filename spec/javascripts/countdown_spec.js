//= require jquery
//= require countdown

function setFixtures(endTime) {
  fixture.set('<p id="end_time">' + new Date(endTime) + '</p>'
      + '<p id="days"></p>'
      + '<p id="hours"></p>'
      + '<p id="minutes"></p>'
      + '<p id="seconds"></p>'
      + '<p id="on-end-test">change on end</p>');
}

function initializeCountdown(endTime, trackingElements){
  var countdown = new Countdown(endTime, trackingElements);
  countdown.onEnd(function() {
    document.getElementById("on-end-test").innerHTML = "it changed!";
  });
  countdown.start();
}

function TrackingElements() {
  this.days = document.getElementById("days")
    this.hours = document.getElementById("hours")
    this.minutes = document.getElementById("minutes")
    this.seconds = document.getElementById("seconds")
}

function setUpTests(endTime) {
  setFixtures(endTime);
  trackingElements = new TrackingElements();
  domEndTime = document.getElementById("end_time").innerHTML;
  domOnEnd = document.getElementById("on-end-test");
  initializeCountdown(domEndTime, trackingElements);
}

describe("Coundown", function() {
  describe("auction is on going", function() {
    beforeEach(function(){
      jasmine.clock().uninstall();
      jasmine.clock().install();
      jasmine.clock().mockDate(new Date());
      endTime = Date.now() + 237300000;
      setUpTests(endTime);
    });

    it("updates countdown in the dom", function() {

      expect(document.getElementById("days").innerHTML).toBe("2");
      expect(document.getElementById("hours").innerHTML).toBe("17");
      expect(document.getElementById("minutes").innerHTML).toBe("54");
      expect(document.getElementById("seconds").innerHTML).toBe("59");

    });

    it("update after a second has passed", function() {
      jasmine.clock().tick(1000);

      expect(document.getElementById("seconds").innerHTML).toBe("58");
    });

    it("update after a minute has passed", function() {
      jasmine.clock().tick(60000);

      expect(document.getElementById("minutes").innerHTML).toBe("53");
    });

    it("update after an hour has passed", function() {
      jasmine.clock().tick(3600000);

      expect(document.getElementById("hours").innerHTML).toBe("16");
    });

    it("update after a day has passed", function() {
      jasmine.clock().tick(86400000);

      expect(document.getElementById("days").innerHTML).toBe("1");
    });

    it("does not modify the on end DOM element", function() {

      expect(domOnEnd.innerHTML).toBe("change on end");
    });
  });

  describe("auction is closed", function() {
    beforeEach(function (){
      endTime = Date.now() - 237300000;
      setUpTests(endTime)
    });

    it("updates the dom with end of event notice", function() {

      expect(document.getElementById("days").innerHTML).toBe("");
      expect(document.getElementById("hours").innerHTML).toBe("");
      expect(document.getElementById("minutes").innerHTML).toBe("");
      expect(document.getElementById("seconds").innerHTML).toBe("");
      expect(domOnEnd.innerHTML).toBe("it changed!");
    });
  });
});
