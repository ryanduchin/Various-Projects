NewsReader.Views.Show = Backbone.View.extend({
  template: JST["feeds/show"],
  tagName: 'ul',
  className: 'list-item',

  events: {
    "click .refresh" : "refresh"
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  refresh: function() {
    // debugger
    // var id = this.model.escape('id');
    // var feed = new NewsReader.Models.Feed({id: id});
    this.model.fetch({
      // success: function(response) { response.latest_entries; }
    });
    // this.model.latest_entries;
    // this.model.fetch()
  }
});
