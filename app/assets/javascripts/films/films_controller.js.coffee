angular.module('Films.controllers.films', ['ui.router'])
.controller 'FilmForm', [
  '$scope'
  '$state'
  'film'
  'railsErrors'
  ($scope, $state, film, railsErrors) ->
    vm = this
    vm.film = film

    vm.save = ->
      vm.film.save().then ->
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
      .state 'films',
        url: '/films'
        abstract: true


      .state 'films.list',
        url: ''
        resolve:
          films: ['Film', (Film) ->
            Film.query()
          ]
        views:
          '@':
            templateUrl: 'films/index.html'
            controller: ['films', (films) ->
                vm = this
                vm.films = films

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'Films'


      .state 'films.new',
        url: '/new'
        resolve:
          film: ['Film', (Film) -> new Film]
        views:
          '@':
            templateUrl: 'films/form.html'
            controller: 'FilmForm as vm'
        ncyBreadcrumb:
          label: 'New'
          parent: 'films.list'


      .state 'films.edit',
        url: '/edit/:id'
        resolve:
          film: ['$stateParams', 'Film', ($stateParams, Film) ->
            Film.get($stateParams.id)
          ]
        views:
          '@':
            templateUrl: 'films/form.html'
            controller: 'FilmForm as vm'
        ncyBreadcrumb:
          label: '{{vm.film.name}}'
          parent: 'films.list'


      .state 'films.show',
        url: '/:id'
        resolve:
          film: ['$stateParams', 'Film', ($stateParams, Film) ->
            Film.get($stateParams.id)
          ]
        views:
          '@':
            templateUrl: 'films/show.html'
            controller: ['film', (film) ->
                vm = this
                vm.film = film

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: '{{vm.film.name}}'

]
