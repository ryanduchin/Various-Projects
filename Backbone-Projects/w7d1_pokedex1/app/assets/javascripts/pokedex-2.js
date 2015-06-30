Pokedex.RootView.prototype.addToyToList = function (toy) {
  return $('<li>').addClass('toy')
                    .html("name: " + toy.get("name") +
                    ", happiness: " + toy.get("happiness") +
                    ", price: " + toy.get("price"))
                    .data('id', toy.get('id'))
                    .data('pokemon-id', toy.get('pokemon'));
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  return $('<div>').addClass('detail')
                   .append($('<img>').attr('src', toy.get("image_url")));
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  console.log("hi mom");
  var toyID = $(event.currentTarget).data('id');
  var pokemonID = $(event.currentTarget).data('pokemon-id');
  var rootView = this;

  rootView.pokes.fetch({
    success: function (pokemons) {
      pokemons.forEach(function (pokemon) {
        if (pokemon.get('id') === pokemonID) {
          pokemon.toys.forEach(function (toy) {
            if (toy.get('id') === toyID) {
              rootView.renderToyDetail(toy);
            }
          });
        }
      });
    }
  });
};
