JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['posts/form'],

  events: {
    "submit form" : "addPost"
  },

  render: function () {
    var content = this.template( { post: this.model });
    this.$el.html(content);
    return this;
  },

  addPost: function(event) {
    event.preventDefault();
    this.$el.find($('.error')).empty();
    var formData = $('form').serializeJSON();
    this.model.save(
      formData.post, {
        update: true,
        wait: true,
        success: function() {
          Backbone.history.navigate("posts/" + this.model.id, {trigger: true});
        }.bind(this),
        error: function (model, response) {
          this.$el.append($('<p>').addClass('error').text(response.responseJSON));
        }.bind(this)
    });
  }
});
