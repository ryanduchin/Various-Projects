
var readline = require('readline');
reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});



var absurdBubbleSort = function (arr, sortCompletionCallBack) {
  var outerBubbleSortLoop = function (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallBack(arr);
    }
  };

      console.log("hi");
  outerBubbleSortLoop(true);
};

var askIfGreaterThan = function (el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + " ?", function(answer) {
    if (answer === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  });
};

var innerBubbleSortLoop = function (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], function(isGreaterThan) {
      if (isGreaterThan) {
        var temp = arr[i + 1];
        arr[i + 1] = arr[i];
        arr[i] = temp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
};

absurdBubbleSort([3, 2, 1, 5], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
