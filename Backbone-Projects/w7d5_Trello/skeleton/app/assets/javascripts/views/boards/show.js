TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  className: 'board-item sortable',

  template: JST['boards/show'],

  events: {
    "click button.delete-board" :  "deleteBoard",
    "click button.add-list" : "addList"
  },


  initialize: function () {
    this.listenTo(this.model, "sync add", this.render);
  },

  render: function () {
    console.log('render board');
    var content = this.template({ board: this.model });
    this.$el.html(content);

    var that = this;
    var board = this.model;
    var board_lists = board.lists();
    board_lists.forEach( function (list) {
      var listView = new TrelloClone.Views.List({
        model: list,
        collection: board_lists,
        board: board
      });
      that.addSubview("ul.board-list-index", listView);
    });

    this.attachSubviews();
    return this;
  },

  deleteBoard: function (event) {
    this.model.destroy();
    Backbone.history.navigate("", { trigger: true });
  },

  addList: function (event) {
    event.preventDefault();
    var list = new TrelloClone.Models.List();
    var createListView = new TrelloClone.Views.ListCreate({
      model: list,
      collection: this.model.lists(),
      board: this.model
    });
    this.addSubview("div.add-list", createListView);
  },
});
