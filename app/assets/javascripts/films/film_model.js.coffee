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

      @intercept 'response', (result, resourceConstructor, context) ->
        if result.data && angular.isArray(result.data.data) and angular.isDefined(result.originalData.total)
          newData = result.data.data.map (v) ->
            new Film(v)
          result.data.data = newData
        result
]
