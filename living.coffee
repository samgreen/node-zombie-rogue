Entity = require './entity'

STATE =
	DEAD: 0
	UNCONSCIOUS: 1
	LIVING: 2

class LivingEntity extends Entity
	constructor: (x, y) ->
		super x, y
		
		@health = @maxHealth = 100
		@state = STATE.LIVING


module.exports = LivingEntity