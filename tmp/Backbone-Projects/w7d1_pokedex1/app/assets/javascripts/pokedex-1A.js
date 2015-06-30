Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $pokeLi = $('<li>').html("Pokemon: " + pokemon.get('name') +
                          ", Type: " + pokemon.get('poke_type'))
                         .addClass('poke-list-item')
                         .data('id', pokemon.get('id'));

  this.$pokeList.append($pokeLi);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var pokemons = this.pokes;
  var rootView = this;

  pokemons.fetch({
    success: function (collection, resp, options) {
      collection.forEach(function (pokemon) {
        rootView.addPokemonToList(pokemon);
      });
    }
  });
};
