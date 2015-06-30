TrelloClone.Views.BoardsIndex = Backbone.View.extend({
  tagName: 'ul',
  className: 'col-md-8 col-md-offset-4 sortable',
  template: JST['boards/index'],

  initialize: function () {
    this.listenTo(this.collection, "sync add remove reset", this.render);
  },

  render: function () {
    var content = this.template({ boards: this.collection });
    this.$el.html(content);
    return this;
  },

});
