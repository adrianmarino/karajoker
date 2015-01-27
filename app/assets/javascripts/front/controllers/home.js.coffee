@HomeController = ($scope, karaokeService) ->
	$scope.state = 'Pause'
	$scope.search = ->
		karaokeService.search $scope.query, (response) ->
			$scope.results = response
