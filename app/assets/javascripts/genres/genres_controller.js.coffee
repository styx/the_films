angular.module('Films.controllers.genres', [])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'genres',
        url: '/genres'
        abstract: true
        template: '<ui-view/>'
      .state 'genres.show',
        url: '/genres/:genreId'
        templateUrl: 'genres/index.html'
        controller: 'GenresController as vm'
      .state 'genres.list',
        url: '/'
        templateUrl: 'genres/index.html'
        controller: 'GenresController as vm'
]

.controller 'GenresController', [
  'Genre'
  (Genre) ->
    vm = this
    vm.genres = []

    Genre.query().then (genres) ->
      vm.genres = genres
]
