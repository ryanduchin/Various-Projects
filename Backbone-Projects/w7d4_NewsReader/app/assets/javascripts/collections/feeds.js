NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: 'api/feeds/',
  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    var feeds = this;
    var feed = this.get(id);

    if (!feed ) {
      feed = new NewsReader.Models.Feed({id: id});
      feed.fetch({
        success: function () { feeds.add(feed); }
      });
    } else {
      feed.fetch();
    }
    return feed;
  }
});
