angular.module('Films.controllers.films', ['ui.router'])
.controller 'FilmForm', [
  '$scope'
  'film'
  'kinds'
  'railsErrors'
  ($scope, film, kinds, railsErrors) ->
    vm = this
    vm.film = film
    vm.kinds = kinds
    vm.kind = film.kind

    vm.save = ->
      vm.film.kind = vm.kind
      vm.film.save().then ->
        $scope.goBack('^.^.list', reload: true)
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
        url: '/list/:page?q'
        resolve:
          currentPage: ['$stateParams', ($stateParams) ->
            $stateParams.page ||= 1
          ],
          films: ['$stateParams', 'Film', 'currentPage', ($stateParams, Film, currentPage) ->
            Film.query($stateParams)
          ]
        views:
          '@':
            templateUrl: 'films/index.html'
            controller: ['films', '$state', 'currentPage', (films, $state, currentPage) ->
              vm = this
              vm.currentPage = currentPage

              if (currentPage != 1 && films.data.length == 0)
                $state.go('films.list', page: currentPage - 1)
              else
                vm.films = films.data
                vm.total = films.total

              vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'Films'


      .state 'films.form',
        url: ''
        abstract: true
        resolve:
          kinds: ['Kind', (Kind) ->
            Kind.query()
          ]

      .state 'films.form.new',
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

      .state 'films.form.edit',
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
        url: '/details/:id'
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
          parent: 'films.list'
          label: '{{vm.film.name}}'

]
