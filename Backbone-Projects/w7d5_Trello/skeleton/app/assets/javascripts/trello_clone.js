
window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new TrelloClone.Routers.Route({
      $rootEl: $('#main')
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
