TrelloClone.Views.List = Backbone.CompositeView.extend({
  tagName: 'div',
  className: 'list-item',
  template: JST['lists/show'],

  //need to implement
  events: {
    "click button.delete-list" :  "deleteList",
    "click button.add-card" : "addCard"
  },

  initialize: function (options) {
    this.board = options.board;

    this.listenTo(this.model, "remove add change", this.render);

  },

  render: function () {
    console.log('render list');
    var content = this.template({ list: this.model });
    this.$el.html(content);

    var that = this;
    var list = this.model;
    var list_cards = list.cards();
    list_cards.forEach( function (card) {
      var cardView = new TrelloClone.Views.Card({
        model: card,
        collection: list_cards,
        list: list,
        board: that.board
      });
      that.addSubview("ul.list-card-index", cardView);
    });

    this.attachSubviews();
    return this;
  },

  deleteList: function (event) {
    event.preventDefault();
    var that = this;
    this.model.destroy();
    Backbone.history.navigate("boards/");
    Backbone.history.navigate("boards/" + that.board.id, {trigger: true});
  },

  addCard: function (event) {
    event.preventDefault();
    var card = new TrelloClone.Models.Card();
    var createCardView = new TrelloClone.Views.CardCreate({
      model: card,
      collection: this.model.cards(),
      list: this.model,
      board: this.board
    });
    this.addSubview("div.add-card", createCardView);
  },

});
