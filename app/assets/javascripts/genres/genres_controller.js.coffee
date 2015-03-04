angular.module('Films.controllers.genres', ['ui.router'])
.config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
      .state 'genres',
        url: '/genres'
        abstract: true

      .state 'genres.list',
        url: ''
        resolve:
          genres: ['Genre', (Genre) ->
            Genre.query()
          ]
        views:
          '@':
            templateUrl: 'genres/index.html'
            controller: ['genres', '$mdDialog', '$state', '$stateParams', (genres, $mdDialog, $state, $stateParams) ->
                vm = this
                vm.genres = genres

                vm.confirmDestroy = (genre) ->
                  confirm = $mdDialog.confirm()
                                     .title('Would you like to delete this genre?')
                                     .content('This one will be removed permanently!')
                                     .ariaLabel('Remove record')
                                     .ok('Please do!')
                                     .cancel('Noooooooo!')

                  $mdDialog.show(confirm).then ->
                    genre.delete().then (genre) ->
                      $state.go $state.current, $stateParams,
                        reload: true
                        inherit: false
                        notify: true

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'Genres'

      .state 'genres.list.new',
        url: '/new'
        views:
          '@':
            templateUrl: 'genres/new.html'
            controller: ['$state', 'Genre', ($state, Genre) ->
                vm = this
                vm.genre = new Genre

                vm.save = ->
                  vm.genre.save()
                  $state.go('^')

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'New'

]
