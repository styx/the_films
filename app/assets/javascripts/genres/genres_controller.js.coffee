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
        resolve:
          genre: ['Genre', (Genre) ->
            new Genre
          ]
        views:
          '@':
            templateUrl: 'genres/form.html'
            controller: ['$state', 'genre', ($state, genre) ->
                vm = this
                vm.genre = genre

                vm.save = ->
                  vm.genre.save().then ->
                    $state.go('^.list', {}, reload: true)

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'New'
          parent: 'genres.list'

      .state 'genres.edit',
        url: '/edit/:id'
        resolve:
          genre: ['$stateParams', 'Genre', ($stateParams, Genre) ->
            Genre.get($stateParams.id)
          ]
        views:
          '@':
            templateUrl: 'genres/form.html'
            controller: ['$state', 'genre', ($state, genre) ->
                vm = this
                vm.genre = genre

                vm.save = ->
                  vm.genre.save().then ->
                    $state.go('^.list', {}, reload: true)

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: '{{vm.genre.name}}'
          parent: 'genres.list'
]
