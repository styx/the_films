angular.module('Films.controllers.kinds', [])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'kinds',
        url: ''
        abstract: true
        template: '<ui-view/>'
      .state 'kinds.list',
        url: '/kinds'
        templateUrl: 'kinds/index.html'
        controller: 'KindsController as vm'
]

.controller 'KindsController', [
  'Kind'
  (Kind) ->
    vm = this
    vm.kinds = []

    Kind.query().then (kinds) ->
      vm.kinds = kinds
]
