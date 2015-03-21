angular.module('Films.services').factory 'Film', [
  'RailsResource'
  'railsSerializer'
  (RailsResource, railsSerializer) ->
    class Film extends RailsResource
      @configure
        url: '/films'
        name: 'film'
        serializer:
          railsSerializer(->
            this.resource('kind', 'Kind')
            this.exclude('kind')
            this.add 'kind_id', (film) ->
              film.kind.id
          )
]
