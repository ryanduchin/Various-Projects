var Board = function () {
  this.grid = [["_","_","_"],["_","_","_"],["_","_","_"]];
};

Board.prototype.place = function ( pos, color ) {
  if ( this.empty(pos) ) {
    this.grid[pos[0]][pos[1] ] = color;
    return true;
  } else {
    //print an error and reset the turn
    return false;
  }
};

Board.prototype.empty = function ( pos ) {
  if ( this.grid[pos[0]][pos[1]] !== "_") {
    return false;
  } else {
    return true;
  }
};

Board.prototype.print = function () {
  console.log(JSON.stringify(this.grid[0]));
  console.log(JSON.stringify(this.grid[1]));
  console.log(JSON.stringify(this.grid[2]));
};

Board.prototype.won = function() {
  return (this.horizontal() || this.vertical() || this.diagonal());
};

Board.prototype.horizontal = function () {
  for ( var row = 0; row < 3; row++ ) {
    var referencePiece = this.grid[row][0];
    if (referencePiece === "_") {
      return false;
    }
    var rowAllSame = true;
    for ( var col = 0; col < 3; col++ ) {
      if (referencePiece !== this.grid[row][col]) {
        rowAllSame = false;
      }
    }
    if (rowAllSame) {
      return true;
    }
  }
  return false;
};

Board.prototype.vertical = function () {
  for ( var col = 0; col < 3; col++ ) {
    var referencePiece = this.grid[0][col];
    if (referencePiece === "_") {
      return false;
    }
    var colAllSame = true;
    for ( var row = 0; row < 3; row++ ) {
      if (referencePiece !== this.grid[row][col]) {
        colAllSame = false;
      }
    }
    if (colAllSame) {
      return true;
    }
  }
  return false;
};

Board.prototype.diagonal = function () {
  var referencePiece = this.grid[1][1];
  if (referencePiece === "_") {
    return false;
  }
  if (this.grid[0][0] === referencePiece && this.grid[2][2] === referencePiece) {
    return true;
  } else if (this.grid[0][2] === referencePiece && this.grid[2][0] === referencePiece) {
    return true;
  } else {
    return false;
  }
};

module.exports = Board;
