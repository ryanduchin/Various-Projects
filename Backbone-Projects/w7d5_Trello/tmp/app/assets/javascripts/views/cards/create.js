TrelloClone.Views.CardCreate = Backbone.View.extend({
  tagName: 'form',
  className: 'create-form',

  template: JST['cards/create'],

  events: {
    "click button.create-card" : "createCard"
  },

  initialize: function(options) {
    this.board = options.board;
    this.list = options.list;
  },

  createCard: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = this.$el.serializeJSON();
    attrs['card']['list_id'] = this.list.id;
    this.model.set(attrs);
    this.model.save({
    }, {
      success: function () {
        that.collection.add(this.model);
        Backbone.history.navigate("boards/");
        Backbone.history.navigate("boards/" + that.board.id, {trigger: true});
      }
    });
  },

  render: function () {
    var content = this.template({
      card: this.model,
      cards: this.collection
    });
    this.$el.html(content);
    return this;
  },

});
