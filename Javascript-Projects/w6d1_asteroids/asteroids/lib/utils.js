(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Util = Asteroids.Util = {};

  Util.inherits = function(ChildClass, ParentClass) {
    var Surrogate = function () {};
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  };

  Util.randomVec = function(length) {
    var multiplier = 1 - Math.floor(Math.random() * 2) * 2;
    return Math.floor(Math.random() * length + 1) * multiplier; //between 1 and 6
  }

  Util.distanceBetween = function(pos1, pos2) {
    return Math.pow(Math.pow((pos2[0]-pos1[0]), 2) +
                    Math.pow((pos2[1]-pos1[1]), 2), 0.5);
  }
})();
