(function () {
  //do we change this to MovingObject so that it inherits from it??
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function(args) {
    args = args || {};

    args["color"] = Ship.COLOR;
    args["radius"] = Ship.RADIUS;
    args["vel"] = [0,0];
    Asteroids.MovingObject.call(this, args);
  };
  
  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.COLOR = "blue";
  Ship.RADIUS = 20;

  Ship.prototype.relocate = function() {
    this.vel = [0,0];
    this.pos = this.game.randomPosition();
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };
})();
