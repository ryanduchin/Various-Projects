Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var rootView = this;

  var $pokeDiv = $('<div>').addClass('detail');

  var $pokeImg = $('<img>').attr('src', pokemon.get('image_url'));
  $pokeDiv.append($pokeImg);

  for (var attr in pokemon.attributes) {
    if (attr === "image_url" ) { continue; }
    $pokeDiv.append($('<div>').html(attr + ": " + pokemon.get(attr)));
  }

  var $pokeToys = $('<ul>').addClass('toys');
  pokemon.fetch({
    success: function (pokey) {
      pokey.toys().forEach(function(toy) {
        $pokeToys.append(rootView.addToyToList(toy));
        rootView.$toyDetail.append(rootView.renderToyDetail(toy));
      });
    }
  });

  $pokeDiv.append($pokeToys);
  this.$pokeDetail.html($pokeDiv);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var pokeID = $(event.currentTarget).data('id');
  var rootView = this;

  rootView.pokes.fetch({
    success: function (pokemons) {
      pokemons.forEach(function (pokemon) {
        if (pokemon.get('id') === pokeID) {
          rootView.renderPokemonDetail(pokemon);
        }
      });
    }
  });
  //....
  //pokemon = this.pokes.get(pokeID)
  //this.renderPokemonDetail(pokemon)
  //lol...
};
