Item = require './item'

class Weapon extends Item
	constructor: (name, description, price, minDamage, maxDamage) ->
		super name, description, price
		@setDamages minDamage, maxDamage

	setDamages: (min, max) ->
		@damage =
			min: min
			max: max
			spread: max - min

	use: (target) ->
		damage = (Math.random() * @damage.spread) + @damage.min
		target.health -= damage