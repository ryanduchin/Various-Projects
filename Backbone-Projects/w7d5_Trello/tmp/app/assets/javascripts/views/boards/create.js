TrelloClone.Views.BoardCreate = Backbone.View.extend({
  tagName: 'form',
  className: 'col-md-8 col-md-offset-4 create-form',

  template: JST['boards/create'],

  events: {
    "click button.create-board" : "createBoard"
  },

  //gets event, not 'formData'
  createBoard: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = this.$el.serializeJSON();
    this.model.set(attrs);
    this.model.save({}, {
      success: function () {
        that.collection.add(this.model);
        Backbone.history.navigate("#", { trigger: true });
      },
    });
  },

  render: function () {
    var content = this.template({
      board: this.model,
      boards: this.collection
    });
    this.$el.html(content);
    return this;
  },

});
