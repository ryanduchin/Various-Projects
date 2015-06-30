Function.prototype.myBind = function(context) {
  var fn = this;
  return function () {
      fn.apply(context);
  };
};

var UFCFighter = function (name) {
  this.name = name;
};

var fighter = new UFCFighter("Ned");
var smacktalk = function() {
  console.log("I am the greatest my name is " + this.name);
};
var talk = smacktalk.myBind(fighter);
talk();
