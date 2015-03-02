angular.module('betterCherkasy.services').factory 'Event', ['$resource', ($resource) ->
  $resource('/events/:id', {id: '@id'}, {update: {method: 'PUT'}})
]
