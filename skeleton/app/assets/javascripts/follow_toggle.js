$.FollowToggle = function (el, options) {
  this.$el = $(el);

  this.userId = this.$el.data('user-id') || options.userId;
  this.followState = this.$el.data('initial-followed-state') || options.followState;
  this.render();
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  this.$el.prop("disabled", false);
  if (this.followState === "unfollowed") {
    this.$el.text("Follow!");
  } else if (this.followState === "followed") {
    this.$el.text("Unfollow!");
  } else if (this.followState === "following" || this.followState === "unfollowing") {
    this.$el.prop("disabled", true);
    this.$el.text(this.followState);
  }
};

$.FollowToggle.prototype.handleClick = function(event) {
  event.preventDefault();
  var requestType;
  if (this.followState === "unfollowed") {
    requestType = "POST";
    this.followState = "following";
  } else {
    requestType = "DELETE";
    this.followState = "unfollowing";
  }
  this.render();
  $.ajax({
    type: requestType,
    url: "/users/" + this.userId + "/follow",
    dataType: "json",
    success: function (response) {
      this.toggleState();
      this.render();
    }.bind(this),
    error: function (req, error, status) {
      console.log("ERROR");
    }
  });
};

$.FollowToggle.prototype.toggleState = function () {
  if (this.followState === "following") {
    this.followState = "followed";
  } else {
    this.followState = "unfollowed";
  }
};


$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $('button.follow-toggle').followToggle();
});
