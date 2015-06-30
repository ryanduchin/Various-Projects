(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
  };

  View.prototype.bindEvents = function () {
    var gameView = this;
    $('.cell').on('click', function(event) {
      gameView.makeMove($(event.currentTarget));
    });
  };

  View.prototype.makeMove = function ($square) {
    var pos = $square.data('pos').split(',');
    try {
      this.game.playMove(pos);
    } catch(MoveError) {
      alert('Invalid Move');
    }
    var symbol = this.game.currentPlayer;
    $square.addClass(symbol);
    $square.text(symbol);
    if (this.game.isOver()) {
      if (this.game.winner()) {
        alert(symbol + " has won!");
      } else {
        alert("NO ONE WINS!");
      }
    }
  };

  View.prototype.setupBoard = function () {
    var board = this.$el;
    for (var i = 0; i < 3; i++) {
      var currentRow = $('<div>').addClass('row').addClass('group');
      for (var j = 0; j < 3; j++) {
        currentRow.append($('<div>').addClass('cell')
        // .addClass('data-pos='{ "x": i, "y", j }''));
        .attr('data-pos', [i, j]));
      }
      board.append(currentRow);
    }
    return board;
  };
})();
