JournalApp.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.collection = new JournalApp.Collections.Posts();
    this.$contentEl = options.$contentEl;
    this.$sideBarEl = options.$sideBarEl;
    this.index();
  },

  routes: {
    "" : "index",
    "posts/new" : "new",
    "posts/:id" : "show",
    "posts/:id/edit" : "edit"
  },

  index: function() {
    this.collection.fetch({ success: function () {
      var view = new JournalApp.Views.PostsIndex( { collection: this.collection });
      this.$sideBarEl.html(view.render().$el);
    }.bind(this)}, { reset: true });
  },

  show: function(id) {
    this.collection.fetch({
      success: function() {
        var post = this.collection.getOrFetch(id);
        var view = new JournalApp.Views.PostShow({ model: post });
        this.$contentEl.html(view.render().$el);
      }.bind(this)
    });
  },

  edit: function(id) {
    this.collection.fetch({ success: function() {
      var post = this.collection.getOrFetch(id);
      var view = new JournalApp.Views.PostForm({ model: post });
      this.$contentEl.html(view.render().$el);
    }.bind(this)});
  },

  new: function() {
    this.collection.fetch({ success: function() {
      var post = new JournalApp.Models.Post();
      var view = new JournalApp.Views.PostForm({ model: post, collection: this.collection });
      this.$contentEl.html(view.render().$el);
    }.bind(this)});
  }
});
