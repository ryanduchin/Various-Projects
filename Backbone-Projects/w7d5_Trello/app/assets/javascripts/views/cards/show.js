TrelloClone.Views.Card = Backbone.View.extend({
  tagName: 'div',
  className: 'card-item',
  template: JST['cards/show'],

  events: {
    "click button.delete-card" : "deleteCard",
  },

  initialize: function (options) {
    this.board = options.board;
    this.list = options.list;

    this.listenTo(this.model, "sync add", this.render);
  },

  render: function () {
    var content = this.template({ card: this.model });
    this.$el.html(content);
    return this;
  },

  deleteCard: function (event) {
    event.preventDefault();
    var that = this;
    this.model.destroy();
    Backbone.history.navigate("boards/");
    Backbone.history.navigate("boards/" + that.list.board.id, {trigger: true});
  },

});
