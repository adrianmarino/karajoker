@HomeController = ($scope) ->
	tags = ['Progresive', 'Metal'].reduce (t,s) -> t + ', '  + s
	karaokes = [ { title: 'Panic Attack', author: 'Dream Threater'}, { title: "From Childhood's Hour...", author: "Circus Maximus" }, { title: 'Upper Levels', author: "Angra" } ]
	$scope.results = karaokes.map (item) -> 
		item["tags"] = tags
		item
