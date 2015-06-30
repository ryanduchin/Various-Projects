(function () {
  //do we change this to MovingObject so that it inherits from it??
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function() {
    this.asteroids = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship ({pos: this.randomPosition(), game: this});
  };

  Game.prototype.allObjects = function() {
    return this.asteroids.concat([this.ship]);
  }

  Game.prototype.addAsteroids = function() {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      var newAsteroid = new Asteroids.Asteroid({pos: this.randomPosition(), game: this});
      this.asteroids.push(newAsteroid);
    }
  };

  Game.prototype.randomPosition = function() {
    return [Math.floor(Math.random() * Game.DIM_X),
                Math.floor(Math.random() * Game.DIM_Y)];
  };

  Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.allObjects().forEach(function(el) {
      el.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function() {
    this.allObjects().forEach(function(el) {
      el.move();
    });
  };

  Game.prototype.wrap = function(pos) {
    if (pos[0] > Game.DIM_X) {
      pos[0] -= Game.DIM_X;
    } else if (pos[0] <= 0) {
      pos[0] += Game.DIM_X;
    }
    if (pos[1] > Game.DIM_Y) {
      pos[1] -= Game.DIM_Y;
    } else if (pos[1] <= 0) {
      pos[1] += Game.DIM_Y;
    }
  };

  Game.prototype.checkCollisions = function() {
    for (var i = 0; i < this.allObjects().length - 1; i++) {
      for (var j = i + 1; j < this.allObjects().length; j++) {
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
          this.allObjects()[i].collideWith(this.allObjects()[j]);
        }
      }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function(asteroid) {
    this.asteroids.splice(this.asteroids.indexOf(asteroid), 1);
  };


  Game.DIM_X = 1000;
  Game.DIM_Y = 1000;
  Game.NUM_ASTEROIDS = 90;
})();
