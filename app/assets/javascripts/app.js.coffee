angular.module('Films', [
  'ngResource'
  'ngMaterial'
  'ui.router'
  'ng-rails-csrf'
  'templates'
  'rails'
  'ncy-angular-breadcrumb'
  'Films.services'
  'Films.directives'
  'Films.controllers'
])

.config [
  '$urlRouterProvider'
  '$mdThemingProvider'
  '$breadcrumbProvider'
  ($urlRouterProvider, $mdThemingProvider, $breadcrumbProvider) ->

    $urlRouterProvider.otherwise('/films')

    $mdThemingProvider.theme('default')
      .primaryPalette('indigo')
      .accentPalette('light-blue')
      .warnPalette('red')

    $breadcrumbProvider.setOptions
      templateUrl: 'breadcrumbs/template.html'
]

.controller 'ApplicationController', [
  '$mdSidenav'
  ($mdSidenav) ->
    this.toggleLeftMenu = ->
      $mdSidenav('left').toggle()

    this.menu = [
      { name: 'Films', state: 'films.list' }
      { name: 'Genres', state: 'genres.list' }
      { name: 'Kinds', state: 'kinds.list' }
    ]

    this.isMenuSelected = (item) ->
      true

]
