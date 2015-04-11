@HomeController = ($scope, PlayerEvent, karaokeService) ->

	$scope.search = ->
		karaokeService.search $scope.query, (response) ->
      if response.length > 0
        $scope.results = response
      else
        $scope.results = [{"title": "Not found karaokes!"}]

  $scope.play = (id)-> 
    $scope.show_player()
    $scope.player.videoid = id

  $scope.$on PlayerEvent.STATUS_CHANGE, (event, data)-> $scope.player.playerStatus = data

  $scope.init = ->
    $scope.player = { width: 640, height: 480, videoid: "", playerStatus: "" }
    $scope.PlayerEvent = PlayerEvent
  $scope.show_player = ->  document.getElementById('video_player').style.display = 'block'
