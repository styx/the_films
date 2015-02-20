angular.module('Films.controllers.kinds', ['ui.router'])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'kinds',
        url: '/kinds'
        abstract: true

      .state 'kinds.list',
        url: ''
        resolve:
          kinds: ['Kind', (Kind) ->
            Kind.query()
          ]
        views:
          '@':
            templateUrl: 'kinds/index.html'
            controller: ['kinds', (kinds) ->
                vm = this
                vm.kinds = kinds
                vm
            ]
            controllerAs: 'vm'

]
