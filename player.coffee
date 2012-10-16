LivingEntity = require './living'

class Player extends LivingEntity

	constructor: (x, y, @name) ->
		super x, y
		# Players start with 100hp
		@health = 100
		# Give them an empty inventory
		@inventory = []

	giveItem: (item) ->
		@inventory.push item

	toString: ->
		return "Player #{ @name }: #{ @health }hp @ (#{ @pos.x }, #{ @pos.y })\n"



module.exports = Player