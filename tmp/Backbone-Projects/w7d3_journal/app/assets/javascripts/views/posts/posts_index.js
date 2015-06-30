JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],
  tagName: 'ul',

  initialize: function () {
    this.listenTo(this.collection, 'update reset change', this.render);

  },

  render: function () {
    this.$el.empty();
    var rootView = this;


    this.collection.each(function(post) {
      var indexItem = new JournalApp.Views.PostsIndexItem({ model: post });
      rootView.$el.append(indexItem.render().$el);
    });

    var content = this.template();
    this.$el.append(content);

    return this;
  }
});
