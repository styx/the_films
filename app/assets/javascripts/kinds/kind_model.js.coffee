angular.module('Films.services').factory 'Kind', [
  'RailsResource'
  (RailsResource) ->
    class Kind extends RailsResource
      @configure url: '/kinds', name: 'kind'
]
