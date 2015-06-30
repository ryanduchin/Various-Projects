TrelloClone.Views.ListCreate = Backbone.View.extend({
  tagName: 'form',
  className: 'create-form',

  template: JST['lists/create'],

  events: {
    "click button.create-list" : "createList"
  },

  initialize: function(options) {
    this.board = options.board;
  },

  createList: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = this.$el.serializeJSON();
    this.model.set(attrs);
    this.model.save({
      board_id: that.board.id,
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
      list: this.model,
      lists: this.collection
    });
    this.$el.html(content);
    return this;
  },

});
