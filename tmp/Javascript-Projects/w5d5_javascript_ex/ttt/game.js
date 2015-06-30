function Game(board, reader) {
  this.board = board;
  this.color = "X";
  this.reader = reader;
  this.message = false;
}

Game.prototype.run = function (completionCallBack) {
  console.log('\033[2J');
  if (this.message) {
    console.log(this.message);
    this.message = false;
  }
  this.board.print();
  console.log("\nIt is " + this.color + "'s turn:\n");
  this.prompt(this.board.place.bind(this.board), this.color, completionCallBack);
};

Game.prototype.prompt = function (callback, color, completionCallBack) {
  var that = this;
  that.reader.question("What row do you want to place your piece in?", function (row) {
    that.reader.question("What column do you want to place your piece in?", function (col) {
      if (row < 0 || row > 2 || col < 0 || col > 2) {
        that.message = "\nEnter numbers between 0 and 2, try again\n";
        that.changeColor();
      } else {
        var placePiece = callback([row, col], color);
        if (!placePiece) {
          that.message = "\nInvalid piece placement\n";
          that.changeColor();
        }
      }
      that.finishTurn(completionCallBack);
    });
  });
};

Game.prototype.finishTurn = function (completionCallBack) {
  if (this.board.won()) {
    this.board.print();
    console.log(this.color + " wins!!!");
    completionCallBack();
  } else {
    this.changeColor();
    this.run(completionCallBack);
  }
};

Game.prototype.changeColor = function () {
  if (this.color === "X") {
    this.color = "O";
  } else {
    this.color = "X";
  }
};

module.exports = Game;
