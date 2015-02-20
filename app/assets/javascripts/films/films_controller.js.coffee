angular.module('Films.controllers.films', [])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'films',
        url: '/films'
        abstract: true
        template: '<ui-view/>'
      .state 'films.list',
        url: ''
        templateUrl: 'films/index.html'
        controller: 'FilmsController as vm'
]

.controller 'FilmsController', [
  'Film'
  (Film) ->
    vm = this
    vm.films = []

    Film.query().then (films) ->
      vm.films = films
]
