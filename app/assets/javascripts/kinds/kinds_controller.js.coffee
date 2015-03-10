angular.module('Films.controllers.kinds', ['ui.router'])
.controller 'KindForm', [
  '$scope'
  '$state'
  'kind'
  'railsErrors'
  ($scope, $state, kind, railsErrors) ->
    vm = this
    vm.kind = kind

    vm.save = ->
      vm.kind.save().then ->
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
        ncyBreadcrumb:
          label: 'Kinds'


      .state 'kinds.new',
        url: '/new'
        resolve:
          kind: ['Kind', (Kind) -> new Kind]
        views:
          '@':
            templateUrl: 'kinds/form.html'
            controller: 'KindForm as vm'
        ncyBreadcrumb:
          label: 'New'
          parent: 'kinds.list'


      .state 'kinds.edit',
        url: '/edit/:id'
        resolve:
          kind: ['$stateParams', 'Kind', ($stateParams, Kind) ->
            Kind.get($stateParams.id)
          ]
        views:
          '@':
            templateUrl: 'kinds/form.html'
            controller: 'KindForm as vm'
        ncyBreadcrumb:
          label: '{{vm.kind.name}}'
          parent: 'kinds.list'
]
