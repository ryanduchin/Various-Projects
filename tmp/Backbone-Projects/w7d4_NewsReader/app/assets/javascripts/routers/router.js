NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$sidebarEl = options.$sidebarEl;

    this.feeds = new NewsReader.Collections.Feeds();
    this.feeds.fetch();
    var content = new NewsReader.Views.Index({ collection: this.feeds });
    this.$sidebarEl.html(content.render().$el);

  },

  routes: {
    "":"index",
    'feeds/:id':"feedShow"
  },

  feedShow: function (id) {
    var feed = this.feeds.getOrFetch(id);
    var currentView = new NewsReader.Views.Show({ model: feed });
    this._swapView(currentView);
  },

  index: function () {
    this.currentView && this.currentView.remove();
    this.currentView = null;
  },

  _swapView: function (newView) {
    this.currentView && this.currentView.remove();
    this.currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
});
