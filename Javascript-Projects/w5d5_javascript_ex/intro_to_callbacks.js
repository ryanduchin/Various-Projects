function Clock () {
  this.seconds = 0;
  this.minutes = 0;
  this.hours = 0;
  this.timeNow = 0;
}

Clock.TICK = 1000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS

  console.log(this.hours + ":" + this.minutes + ":" + this.seconds);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  var that = this;
  this.timeNow = new Date();
  this.hours = this.timeNow.getHours();
  this.minutes = this.timeNow.getMinutes();
  this.seconds = this.timeNow.getSeconds();
  this.printTime();
  setInterval(this._tick.bind(that), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.seconds += 5;
  this.updateTime();
  this.printTime();
};

Clock.prototype.updateTime = function () {
  while (this.seconds >= 60) {
    this.seconds -= 60;
    this.minutes += 1;
  }
  while (this.minutes >= 60) {
    this.minutes -= 60;
    this.hours += 1;
  }
};

var clock = new Clock();
clock.run();
