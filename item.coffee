class Item
	constructor: (@name, @description, @price) ->

	use: (target) ->
		return "Nothing happens when you use #{ @name } on #{ target }"
		
	toString: ->
		return "Name: #{ @name }\n
				Description: #{ @description }\n
				Price: #{ @price }"