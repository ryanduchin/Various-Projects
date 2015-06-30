JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST['posts/index_show'],
  render: function() {
    var content = this.template( { post: this.model });
    this.$el.html(content);
    return this;
  }
});
