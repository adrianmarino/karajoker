angular.module('karajoker').factory('karaokeService', ['$http', ($http) ->
  service = {}
  service.search = (a_query, results) -> $http.get('api/karaokes/search/' + a_query).success(results).error( -> console.error 'Failed to search karaoke!')
  service
])