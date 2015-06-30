TrelloClone.Routers.Route = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.boards = new TrelloClone.Collections.Boards();
    this.boards.fetch();
  },

  routes: {
    "": "boards_index",
    "boards/new" : "boards_new",
    "boards/:id" : "boards_show",
  },

  boards_index: function (id) {
    this.boards.fetch(); //
    var indexView = new TrelloClone.Views.BoardsIndex({
      collection: this.boards,
    });
    this.swapView(indexView);
  },

  boards_show: function (id) {
    var board = this.boards.getOrFetch(id);
    var showView = new TrelloClone.Views.BoardShow({
      model: board,
    });
    this.swapView(showView);
  },

  boards_new: function () {
    var newBoard = new TrelloClone.Models.Board();
    var createView = new TrelloClone.Views.BoardCreate({
      model: newBoard,
      collection: this.boards,
    });
    this.swapView(createView);
  },


  swapView: function (newView) {
    //remove() function
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(this._currentView.render().$el);
  },

});
