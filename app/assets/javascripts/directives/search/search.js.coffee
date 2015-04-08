angular.module('Films.directives.stSearch', [])
  .directive 'stSearch', [
    '$rootScope'
    '$state'
    '$stateParams'
    ($rootScope, $state, $stateParams) ->
      restrict: 'E'
      templateUrl: 'directives/search/template.html'
      link: ($scope, elem, attr, ctrl) ->

        input = elem.find('input')

        $rootScope.$on '$stateChangeSuccess', (ev, to, toParams, from, fromParams) ->
          $scope.q = $stateParams['q']

        $scope.clear = ->
          $scope.q = ''
          input.focus()

        elem.bind 'keydown keypress', (e) ->
          if (e.which == 13)
            $state.go($state.current.name, angular.extend($stateParams, {page: undefined, q: $scope.q}))

            e.preventDefault()
  ]
