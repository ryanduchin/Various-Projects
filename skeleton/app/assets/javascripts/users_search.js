$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('.search-input');
  this.$ul = this.$el.find('.users');
  this.$input.on('keydown', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  var callAjax = function () {
    $.ajax({
      url: "/users/search",
      data: {
        "query": this.$input.val()
      },
      dataType: "json",
      success: this.renderResults.bind(this),
      error: function () {
        console.log("ERROR");
      }
    });
  }.bind(this);
  setTimeout(callAjax, 0);
};

$.UsersSearch.prototype.renderResults = function(response) {
  this.$ul.empty();
  console.log(response);
  response.forEach(function(el) {
    var $anchor = $('<a>').attr("href", "/users/" + el.id).text(el.username);
    var $button = $('<button>').addClass("follow-toggle");
    $button.followToggle({
      "userId": el.id,
      "followState": el.followed ? "followed" : "unfollowed"
    });

    this.$ul.append($('<li>').append($anchor).append($button));
  }.bind(this));

};


$.fn.usersSearch = function() {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $('div.users-search').usersSearch();
});
