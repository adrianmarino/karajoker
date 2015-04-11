app.factory 'karaokeService', ($http) ->
  service = {}
  service.search = (a_query, a_callback) ->
  	$http.get('api/karaokes/search/' + a_query).success(
  		(a_response)-> a_callback a_response
  	).error( -> console.error 'Failed to search karaoke!') if a_query
  service
