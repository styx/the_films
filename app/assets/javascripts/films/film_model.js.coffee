angular.module('Films.services').factory 'Film', [
  'RailsResource'
  (RailsResource) ->
    class Film extends RailsResource
      @configure url: '/films', name: 'film'
]
