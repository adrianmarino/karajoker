@HomeController = ($scope, karaokeService) ->
	$scope.search = ->
		console.log "Search:" + this.query
		karaokeService.search this.query, (response) -> $scope.results = response
		