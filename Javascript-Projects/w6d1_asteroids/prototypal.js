
Function.prototype.inherits = function(superclass) {
  var Surrogate = function() {};
  Surrogate.prototype = superclass.prototype;
  this.prototype = new Surrogate();
};

function MovingObject () {};

MovingObject.prototype.move = function() {
  console.log("moving!");
};

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {};
Asteroid.inherits(MovingObject);
Asteroid.prototype.blast = function() {
  console.log("outerspace blasting peew!");
};

Ship.prototype.newMethod = function() {
  console.log("a method only for ships");
};



var ship = new Ship();
var asteroid = new Asteroid();
var mo = new MovingObject();


ship.move();
asteroid.move();
asteroid.blast();
// ship.blast(); // error
// mo.newMethod(); // error
