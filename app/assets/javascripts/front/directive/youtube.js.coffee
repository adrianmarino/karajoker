app.constant 'PlayerEvent', { STOP: 0, PLAY: 1, PAUSE: 2, STATUS_CHANGE: 3 }

app.directive 'youtube', ($window, PlayerEvent, PlayerConfig)->
  {
    restrict: "E",
    scope: { height: "@", width: "@", videoid: "@" },
    template: '<div></div>',
    link: (scope, element, attrs, $rootScope)->
      tag = document.createElement('script')
      tag.src = "https://www.youtube.com/iframe_api"
      firstScriptTag = document.getElementsByTagName('script')[0]
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)

      player = null

      $window.onYouTubeIframeAPIReady = ()->
        player = new YT.Player(element.children()[0],
          playerVars: PlayerConfig
          height: scope.height
          width: scope.width
          videoId: scope.videoid
          events:
            onStateChange: (api_event)-> scope.send_player_event(scope.youtube_to_player_event(api_event))
        )

      scope.$watch 'height + width', (newValue, oldValue)->
        player.setSize(scope.width, scope.height) if newValue != oldValue

      scope.$watch 'videoid', (newValue, oldValue)->
        player.cueVideoById(scope.videoid) if newValue != oldValue

      scope.$on PlayerEvent.STOP, ->
        player.seekTo(0)
        player.stopVideo()

      scope.$on PlayerEvent.PLAY,  -> player.playVideo()

      scope.$on PlayerEvent.PAUSE, ->  player.pauseVideo

      scope.play_event  = -> { event: PlayerEvent.PLAY, data: "Playing"}
      scope.null_event  = -> scope.event("")
      scope.event       = (data)-> { event: PlayerEvent.STATUS_CHANGE, data: data }

      scope.youtube_to_player_event = (api_event)->
        # YT.PlayerState.PLAYING    =1
        # YT.PlayerState.ENDED      =0
        # YT.PlayerState.UNSTARTED  =-1
        # YT.PlayerState.CUED       =5
        # YT.PlayerState.PAUSED     = 2
        player_event = switch api_event.data
                  when YT.PlayerState.UNSTARTED then scope.play_event()
                  when YT.PlayerState.PLAYING   then scope.event("Playing")
                  when YT.PlayerState.CUED      then scope.event("Playing")
                  when YT.PlayerState.PAUSED    then scope.event("Pause")
                  when YT.PlayerState.ENDED     then scope.null_event()
                  else scope.null_event()
        # console.log("API    Event: ", api_event)
        # console.log("Player Event: ", player_event)
        player_event

      scope.send_player_event = (player_event)-> 
        scope.$apply -> scope.$emit(player_event.event, player_event.data)
  }
