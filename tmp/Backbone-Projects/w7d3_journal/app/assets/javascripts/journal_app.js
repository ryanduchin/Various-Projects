window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new JournalApp.Routers.Router({
      $contentEl:  $('.content'),
      $sideBarEl: $('.sidebar')
    });
    Backbone.history.start();
  }

};

$(document).ready(function(){
  JournalApp.initialize();
});
