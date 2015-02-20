angular.module('Films.controllers.genres', ['ui.router'])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'genres',
        url: '/genres'
        abstract: true

      .state 'genres.list',
        url: ''
        resolve:
          genres: ['Genre', (Genre) ->
            Genre.query()
          ]
        views:
          '@':
            templateUrl: 'genres/index.html'
            controller: ['genres', (genres) ->
                vm = this
                vm.genres = genres

                vm
            ]
            controllerAs: 'vm'

]
