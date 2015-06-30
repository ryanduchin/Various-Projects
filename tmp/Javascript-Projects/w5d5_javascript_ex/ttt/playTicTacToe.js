var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

TTT = require('./index.js')
var board = new TTT.Board();
var game = new TTT.Game(board, reader);

game.run(function () {
  reader.close();
});
