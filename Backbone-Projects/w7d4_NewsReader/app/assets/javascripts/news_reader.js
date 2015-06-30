window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // initialize a router and hook it into the DOM
    this.$rootEl = $('#content');
    this.$sidebarEl = $('#sidebar');

    new NewsReader.Routers.Router({
      $rootEl: this.$rootEl, $sidebarEl: this.$sidebarEl
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
