var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var HanoiGame = function () {
  var that = this;
  this.stacks = [[3,2,1],[],[]];
};

HanoiGame.prototype.isWon = function () {
  if (this.stacks[0].length < 1 && (this.stacks[1].length < 1 || this.stacks[2].length < 1)) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  if (startTowerIdx > 2 || startTowerIdx < 0 || endTowerIdx > 2 || endTowerIdx < 0) { return false };
  var startStack = this.stacks[startTowerIdx];
  var startPiece = startStack[startStack.length-1];
  var endStack = this.stacks[endTowerIdx];
  var endPiece = endStack[endStack.length-1];
  if (startStack.length > 0) {
    if (endPiece && startPiece < endPiece) {
      return true;
    }
    else if (!endPiece) {
      return true;
    } else {
      return false;
    }
  }
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.printStack = function () {
  var string = JSON.stringify(this.stacks);
  console.log(string);
};

HanoiGame.prototype.promptMove = function (callback) {
  this.printStack();
  reader.question("Where would you like to move from?", function (fromStack) {
    reader.question("Where would you like to move to?", function (toStack) {
      callback(fromStack, toStack);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  that.promptMove(function(fromStack, toStack) {
    if (!that.move(fromStack, toStack)) {
      console.log("Move failed");
    }
    if (!that.isWon()) {
      that.run(completionCallback);
    } else {
      console.log("You won.");
      completionCallback();
    }
  });
};


var game = new HanoiGame();
game.run(function() {
  reader.close();
})
