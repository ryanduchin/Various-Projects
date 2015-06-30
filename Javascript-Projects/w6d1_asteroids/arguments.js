function sum() {
  var sum = 0;
  var args = [].slice.call(arguments);
  args.forEach(function(el) {
    sum += el;
  });
  return sum;
}


Function.prototype.myBind = function(obj) {
  var fn = this;
  var args = [].slice.call(arguments, 1);
  return function() {
    args = args.concat([].slice.call(arguments, 0));
    fn.apply(obj, args);
  };
};


function curriedSum(numArgs) {
  var numbers = [];
  function _curriedSum(num) {
    numbers.push(num);
    if (numbers.length >= numArgs) {
      var sum = 0;
      numbers.forEach(function(el) {
        sum += el;
      });
      return sum;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

var sum = curriedSum(4);
console.log(sum(5)(30)(20)(1));

Function.prototype.curry = function(numArgs) {
  var args = [];
  function _curried(value) {
    args.push(value);
    if (args.length >= numArgs) {
      return this.apply(null, args);
    } else {
      return _curried;
    }
  }.myBind(this)

  return _curried;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

console.log(sumThree.curry(3)(4)(20)(6)); // 30
