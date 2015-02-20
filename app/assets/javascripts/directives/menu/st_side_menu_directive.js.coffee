angular.module('Films.directives.stSideMenu', [])
  .directive 'stSideMenu', ->
    restrict: 'E'
    scope:
      items: '='
    templateUrl: 'directives/menu/menu.html'
