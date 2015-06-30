var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter number: ", function(answer1) {
      var num1 = parseInt(answer1);
      sum += num1;
      numsLeft--;
      console.log(sum);
      addNumbers(sum, numsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
};


addNumbers(0, 1, function (sum) {
  console.log("Total Sum: " + sum);
});
