LivingEntity = require './living'

class Zombie extends LivingEntity
	constructor: (x, y) ->
		super x, y

	attack: (player) ->
		damage = Math.floor Math.random() * 5
		player.health -= damage

	toString: ->
		return "Zombie: #{ @name }hp @ (#{ @pos.x }, #{ @pos.y })\n"

module.exports = Zombie