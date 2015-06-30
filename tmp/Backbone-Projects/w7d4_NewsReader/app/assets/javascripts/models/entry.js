NewsReader.Models.Entry = Backbone.Model.extend({

  urlRoot: function() {
    return '/api/feeds/' + this.feed.id + '/entries';
  }
})
