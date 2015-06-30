TrelloClone.Collections.Boards = Backbone.Collection.extend({
  //rails url includes api!!!
  url: '/api/boards',

  //!
  model: TrelloClone.Models.Board,

  //!
  getOrFetch: function (id) {
    var boards = this;
    var board = this.get(id);

    if (!board) {
      board = new TrelloClone.Models.Board({id: id});
      board.fetch({
        success: function() {
          boards.add(board);
        }
      });
    } else {
      board.fetch();
    }

    return board;
  }

});
