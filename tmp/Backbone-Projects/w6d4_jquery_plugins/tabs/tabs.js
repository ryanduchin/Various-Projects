
$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("content-tabs"));
  this.$activeTab = this.$contentTabs.find('.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
  this.transitioning = false;
};

$.Tabs.prototype.clickTab = function (event) {
  if (this.transitioning) { return; }

  this.transitioning = true;
  // $('a').removeClass('active');
  // this.$activeTab.removeClass('active').addClass('transitioning');
  $('.active').removeClass('active');
  this.$activeTab.addClass('transitioning');
  var $targeta = $(event.currentTarget);
  var currentFor = $targeta.attr('for');
  this.$activeTab.one("transitionend", this.transitionEnd.bind(this, $targeta, currentFor));
  //goes in setTimeout
};

$.Tabs.prototype.transitionEnd = function($targeta, currentFor) {
  this.$activeTab.removeClass('transitioning');
  this.$activeTab = $(currentFor).addClass('transitioning');
  setTimeout(function() {
    this.$activeTab.removeClass('transitioning').addClass('active');
    this.$activeTab.one('transitionend', function () {
      this.transitioning = false;
    }.bind(this));
  }.bind(this), 0);
  $targeta.addClass('active');
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
