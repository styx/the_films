angular.module('Films.controllers.genres', ['ui.router'])
.controller 'GenreForm', [
  '$scope'
  '$state'
  'genre'
  'railsErrors'
  ($scope, $state, genre, railsErrors) ->
    vm = this
    vm.genre = genre

    vm.save = ->
      vm.genre.save().then ->
        $state.go('^.list', {}, reload: true)
      ,
        (response) ->
          railsErrors.apply($scope.form, response)

    vm
]

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
          genre: ['Genre', (Genre) -> new Genre]
        views:
          '@':
            templateUrl: 'genres/form.html'
            controller: 'GenreForm as vm'
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
            controller: 'GenreForm as vm'
        ncyBreadcrumb:
          label: '{{vm.genre.name}}'
          parent: 'genres.list'
]
