(function () {
  //do we change this to MovingObject so that it inherits from it??
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function(game, ctx) {
    this.game = game;
    this.ctx = ctx
  };

  GameView.prototype.start = function() {
    window.setInterval((function() {
      this.game.step();
      this.game.draw(this.ctx);
      this.bindKeyHandlers();
    }).bind(this), 20);
  };

  GameView.prototype.bindKeyHandlers = function() {
    key(38, this.game.ship.power([0, 1]));
    key(40,  this.game.ship.power([0, -1]));
    key(37,  this.game.ship.power([-1, 0]));
    key(39,  this.game.ship.power([1, 0]));

  }

})();
