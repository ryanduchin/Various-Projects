TrelloClone.Collections.Lists = Backbone.Collection.extend({
  //rails url includes api!!!
  url: '/api/lists',

  model: TrelloClone.Models.List,

  //so that lists are showed in order of rank (on board show page)
  comparator: function (list) {
    return list.get('ord');
  },

});
