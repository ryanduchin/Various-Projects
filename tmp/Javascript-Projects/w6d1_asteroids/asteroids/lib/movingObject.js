(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var MovingObject = Asteroids.MovingObject = function(args) {
    this.pos = args["pos"];
    this.vel = args["vel"];
    this.radius = args["radius"];
    this.color = args["color"];
    this.game = args["game"];
  };

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  };

  MovingObject.prototype.move = function() {
    this.pos[0] = this.pos[0] + this.vel[0];
    this.pos[1] = this.pos[1] + this.vel[1];
    this.game.wrap(this.pos);
  };

  MovingObject.prototype.isCollidedWith = function(otherObject) {
    var dist = Asteroids.Util.distanceBetween(this.pos, otherObject.pos);
    if (dist <= (this.radius + otherObject.radius)) {
      return true;
    } else {
      return false;
    }
  };

  MovingObject.prototype.collideWith = function(otherObject) {};

})();
