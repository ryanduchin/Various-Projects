(function () {
  //do we change this to MovingObject so that it inherits from it??
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function(args) {
    args = args || {};

    args["color"] = Asteroid.COLOR;
    args["radius"] = Asteroid.RADIUS;
    args["vel"] = [Asteroids.Util.randomVec(7), Asteroids.Util.randomVec(7)];
    Asteroids.MovingObject.call(this, args);
  };
  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.COLOR = "red";
  Asteroid.RADIUS = 20;

  Asteroid.prototype.collideWith = function(otherObject) {
    if (otherObject instanceof window.Asteroids.Ship) {
      otherObject.relocate();
    } else {
      this.game.remove(otherObject);
    }
    this.game.remove(this);
  };

})();
