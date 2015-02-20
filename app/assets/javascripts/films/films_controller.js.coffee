angular.module('Films.controllers.films', ['ui.router'])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'films',
        url: '/films'
        abstract: true

      .state 'films.list.show',
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

]
