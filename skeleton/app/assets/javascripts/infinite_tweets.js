$.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.$el.find('.fetch-more').on('click', this.fetchTweets.bind(this));
};

$.InfiniteTweets.prototype.fetchTweets = function() {
  $.ajax({
    url: "/feed",
    dataType: "json",
    success: this.insertTweets.bind(this)
  });
};

$.InfiniteTweets.prototype.insertTweets = function (response) {
  console.log(response);
  var $feedUl = this.$el.find('#feed');
  response.tweets.forEach(function(tweet){
    $feedUl.append($('<li>').text(JSON.stringify(tweet)));
  });

};

$.fn.infiniteTweets = function() {
  return this.each(function() {
    new $.InfiniteTweets(this);
  });
};

$(function() {
  $('.infinite-tweets').infiniteTweets();
});
