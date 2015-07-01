$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$el.on('submit', this.submit.bind(this));
  this.$el.find('textarea').on('keyup', this.checkTweetLength.bind(this));
  this.$el.find('.add-mentioned-user').on('click', this.addMentionedUser.bind(this));
  this.$el.on('click', 'a.remove-mentioned-user', this.removeMentionedUser.bind(this));
};

$.TweetCompose.prototype.addMentionedUser = function() {
  var $scriptTag = $(this.$el.find('script'));
  $($scriptTag.html()).appendTo(this.$el.find('.mentioned-users'));
};

$.TweetCompose.prototype.removeMentionedUser = function (event) {
  var $clickedLink = $(event.currentTarget);
  if ($clickedLink.attr('class') === 'remove-mentioned-user') {
    $clickedLink.parent().remove();
  }
};

$.TweetCompose.prototype.checkTweetLength = function (event) {
  var charsLeft = 140 - this.$el.find('textarea').val().length;
  if (charsLeft === 140) {
    this.$el.find('.chars-left').text("");
  } else if (charsLeft >= 0) {
    this.$el.find('.chars-left').text(charsLeft + " Characters Left");
  } else {
    this.$el.find('.chars-left').text("tweet too long!");
  }
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  $.ajax({
    url: "/tweets",
    type: "post",
    dataType: "json",
    data: this.$el.serializeJSON(),
    success: this.handleSuccess.bind(this),
    error: function () {
      alert("Not a valid tweet!");
      this.clearInput();
      this.$el.find(':input').prop("disabled", false);
    }.bind(this)
  });
  this.$el.find(':input').prop("disabled", true);
};

$.TweetCompose.prototype.clearInput = function() {
  this.$el.find(':input:not(.submit-button)').val('');
  this.$el.find('.chars-left').text("");
  this.$el.find('.mentioned-users').empty();
};

$.TweetCompose.prototype.handleSuccess = function(response) {
  this.clearInput();
  this.$el.find(':input').prop("disabled", false);
  var feedUL = $(this.$el.data("tweets-ul"));
  feedUL.prepend($('<li>').text(JSON.stringify(response.content)));
};


$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $('form.tweet-compose').tweetCompose();
});
