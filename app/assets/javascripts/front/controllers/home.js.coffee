@HomeController = ($scope, karaokeService) ->
	$scope.state = 'Pause'
	$scope.search = ->
		karaokeService.search $scope.query, (response) ->
			if response.length > 0
				$scope.results = response
			else
				$scope.results = [{"title": "Not found karaokes!"}]
