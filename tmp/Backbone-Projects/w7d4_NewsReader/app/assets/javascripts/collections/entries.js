NewsReader.Collections.Entries = Backbone.Collection.extend({
  //needs initialize method taking options and setting this.feed = options.feed
  //because of ./models/feed.js
  model: NewsReader.Models.Entry,

  url: function () {
    return '/api/feeds/' + this.feed.id + '/entries';
  },

  comparator: -'published_at'
});
