angular.module('Films.directives.stConfirmDestroy', [])
.directive 'stConfirmDestroy', [
  '$mdDialog'
  '$mdToast'
  '$state'
  '$stateParams'
  ($mdDialog, $mdToast, $state, $stateParams) ->
    restrict: 'A'
    scope: {
      obj: '=stConfirmDestroy'
    }
    link: (scope, element, attributes) ->
      obj = scope.obj
      element.bind 'click', ->
        confirm = $mdDialog.confirm()
                           .title('Confirm destructive action')
                           .content("\"#{obj.name}\" will be removed permanently!")
                           .ariaLabel('Remove record')
                           .ok('Please do!')
                           .cancel('Noooooooo!')

        $mdDialog.show(confirm).then ->
          obj.delete().then (obj) ->
            $state.forceReload()
          ,
            (response) ->
              message = response.data.errors.base.join("\n")
              $mdToast.show(
                $mdToast.simple()
                  .content(message)
                  .position('top right')
              )
]
