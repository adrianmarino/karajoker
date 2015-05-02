app.config ($locationProvider) ->
  $locationProvider.html5Mode { enable: true, requireBase: false }

app.constant 'PlayerConfig', {
  autoplay: 1,
  html5: 1,
  theme: "dark",
  color: "white",
  iv_load_policy: 3,
  showinfo: 0,
  controls: 1,
  cc_load_policy: 0,
  modestbranding: 1,
  rel: 0
}
