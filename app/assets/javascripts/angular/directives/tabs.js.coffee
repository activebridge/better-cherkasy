directives = angular.module('betterCherkasy')
directives.directive 'showtab', ->
  { link: (scope, element, attrs) ->
    element.click (e) ->
      e.preventDefault()
      $(element).tab 'show'
      return
    return
 }
