NewsReader.Views.Index = Backbone.View.extend({
  template: JST["feeds/index"],
  tagName: 'ul',
  className: 'list-group',

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);

    return this;
  }


});
