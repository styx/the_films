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
        ncyBreadcrumb:
          label: 'Genres'

      .state 'genres.new',
        url: '/new'
        views:
          '@':
            templateUrl: 'genres/new.html'
            controller: ['$state', 'Genre', ($state, Genre) ->
                vm = this
                vm.genre = new Genre

                vm.save = ->
                  vm.genre.save()
                  $state.go('^.list', {}, reload: true)

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'New'

]
