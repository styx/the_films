angular.module('Films.services').factory 'Genre', [
  'RailsResource'
  (RailsResource) ->
    class Genre extends RailsResource
      @configure url: '/genres', name: 'genre'
]
