TrelloClone.Collections.Cards = Backbone.Collection.extend({
  //rails url includes api!!!
  url: '/api/cards',

  model: TrelloClone.Models.Card,

  comparator: function (card) {
    return card.get('ord');
  },

});
