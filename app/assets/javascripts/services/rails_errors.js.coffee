angular.module('Films.services').factory 'railsErrors', [
  ->
    {
      apply: (form, response) ->
        angular.forEach response.data, (errors, key) ->
          angular.forEach errors, (e) ->
            form[key].$dirty = true
            form[key].$setValidity(e, false)
    }
]
