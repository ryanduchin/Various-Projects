Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var rootView = this;
  debugger;
  var newPokemon = new Pokedex.Models.Pokemon(attrs.pokemon);

  newPokemon.save({}, {
    success: function() {
      rootView.pokes.push(newPokemon);
      rootView.addPokemonToList(newPokemon);
      callback.call(rootView, newPokemon);
    }
  });


};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  this.createPokemon($(event.currentTarget).serializeJSON(),
                          this.renderPokemonDetail).bind(this);
};
