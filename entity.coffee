class Entity
	constructor: (x, y) ->
		@setPosition x, y

	setPosition: (x, y) ->
		@pos =
			x: x
			y: y

		return @pos



module.exports = Entity