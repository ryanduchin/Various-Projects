(function() {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.$el = $el;
    this.selectedTower;

    this.setupTowers();
    this.clickTower();
  };

  View.prototype.setupTowers = function() {
    var gameView = this;
    for(var i = 0; i < 3; i++) { //towers
      gameView.$el.append($('<div>').addClass('tower').attr('data-tower', i));
      var gameTower = gameView.game.towers[i];
      var tower;
      for (var j = gameTower.length - 1; j >= 0; j--) { //pieces
        var pieceNum = gameView.game.towers[i][j];
        tower = $('.tower').data('tower', i);
        tower.append($('<div>').addClass('piece').attr('data-piece', pieceNum));
      }
    }
    var tower1 = $('[data-tower=1]');
    tower1.append($('<div>').addClass('dummy'));
    tower1.append($('<div>').addClass('dummy'));
    tower1.append($('<div>').addClass('dummy'));
    var tower2 = $('[data-tower=2]');
    tower2.append($('<div>').addClass('dummy'));
    tower2.append($('<div>').addClass('dummy'));
    tower2.append($('<div>').addClass('dummy'));
  };

  View.prototype.render = function() {
    var gameView = this;
    $('.dummy').remove();
    for (var k = 0; k < 3; k++) { //towers for dummies
      var tower = $('[data-tower=' + k + ']');
      var numPieces = gameView.game.towers[k].length;
      while (numPieces < 3) {
        tower.append($('<div>').addClass('dummy'));
        numPieces++;
      }
    }

    for (var i = 1; i < 4; i++) { //pieces
      var piece = $('[data-piece=' + i + ']');
      piece.remove();
      //get tower index
      var desiredTower;
      for (var j = 0; j < 3; j++ ) { //towers
        var gameTower = gameView.game.towers[j];
        // console.log(gameTower)
        // console.log(gameTower.indexOf(i + 1))
        if (gameTower.indexOf(i) !== -1) {
          desiredTower = j;
        }
      }
      //get the jquery element of the tower desiredTower
      //append piece to it
      var tower = $('[data-tower=' + desiredTower + ']');
      tower.append(piece);
    }

  };

  View.prototype.clickTower = function() {
    var gameView = this;
    $('.tower').on('click', function(event) {
      if (gameView.selectedTower === undefined) {
        gameView.selectedTower = $(event.currentTarget);
        gameView.selectedTower.addClass('clicked');
      } else {
        var tower2 = $(event.currentTarget);
        gameView.game.move(gameView.selectedTower.data('tower'), tower2.data('tower'));
        gameView.selectedTower.removeClass('clicked');
        gameView.render();
        gameView.selectedTower = undefined;
        if (gameView.game.isWon()) {
          alert('Congratulations, you won!');
        }
      }
    });
  };
})();
