angular.module('Films.directives.stSearch', [])
  .directive 'stSearch', [
    '$location'
    ($location) ->
      restrict: 'E'
      templateUrl: 'directives/search/template.html'
      link: ($scope, elem, attr, ctrl) ->
        q = $location.search()['q']
        if (typeof q == 'string')
          $scope.q = q

        input = elem.find('input')

        $scope.clear = ->
          $scope.q = ''
          input.focus()

        elem.bind 'keydown keypress', (e) ->
          if (e.which == 13)
            $scope.$apply ->
              newSearchPath = angular.extend($location.search(), {q: $scope.q})
              $location.search(newSearchPath)

            e.preventDefault()
  ]
