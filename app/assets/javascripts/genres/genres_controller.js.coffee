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
            controller: ['genres', '$mdDialog', '$mdToast', '$state', '$stateParams', (genres, $mdDialog, $mdToast, $state, $stateParams) ->
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
                      $state.forceReload()
                    ,
                      (response) ->
                        message = response.data.errors.base.join("\n")
                        $mdToast.show(
                          $mdToast.simple()
                            .content(message)
                            .position('top right')
                        )

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'Genres'

      .state 'genres.new',
        url: '/new'
        views:
          '@':
            templateUrl: 'genres/new.html'
            controller: ['$state', 'Genre', ($state, Genre) ->
                vm = this
                vm.genre = new Genre

                vm.save = ->
                  vm.genre.save()
                  $state.go('^.list', {}, reload: true)

                vm
            ]
            controllerAs: 'vm'
        ncyBreadcrumb:
          label: 'New'

]
