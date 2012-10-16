fs = require 'fs'

Zombie = require './zombie'
Player = require './player'

MAP_VALUES = [ 0, 1, 2, 3, 4, 5 ]
MAP_NAMES =
	GRASS: 0
	WALL: 2
	DOOR: 3

class World
	constructor: (options) ->
		@player = new Player 0, 0, 'Timothy Teste'
		
		unless options.file
			@size = options.size || { x: 80, y: 24 }

			@initMap()
		else
			@loadMap options.file

		@spawnZombies()

	loadMap: (file) ->
		info = JSON.parse fs.readFileSync(file)
		@name = info.name
		@description = info.description
		@mapData = info.mapData
		@size =
			x: @mapData[0].length
			y: @mapData.length

	initMap: ->
		@mapData = []
		for x in [0..@size.x]
			@mapData[x] = []
			for y in [0..@size.y]
				@mapData[x][y] = MAP_NAMES.GRASS

		@generateRooms()

	generateRooms: ->
		for i in [0..4]	
			room =
				location: @randomLocation()
				width: Math.floor(Math.random() * 8) + 4
				height: Math.floor(Math.random() * 8) + 4

			if room.location.x + room.width > @size.x
				room.location.x -= room.width

			if room.location.y + room.height > @size.y
				room.location.y -= room.height

			for x in [room.location.x..room.location.x+room.width]
				@mapData[x][room.location.y] = MAP_NAMES.WALL
				@mapData[x][room.location.y + room.height] = MAP_NAMES.WALL

			for y in [room.location.y..room.location.y+room.height]
				@mapData[room.location.x][y] = MAP_NAMES.WALL
				@mapData[room.location.x + room.width][y] = MAP_NAMES.WALL

	randomizeMap: ->
		@mapData = []
		for x in [0..@size.x]
			@mapData[x] = []
			for y in [0..@size.y]
				@mapData[x][y] = @randomMapValue()

	randomLocation: ->
		location =
			x: Math.floor Math.random() * @size.x
			y: Math.floor Math.random() * @size.y


	randomMapValue: ->
		plainSpawn = (Math.random() * 5 > 2)
		if plainSpawn
			return 0

		index = Math.floor(Math.random() * MAP_VALUES.length)
		return MAP_VALUES[ index ]

	spawnZombies: ->
		@zombies = []
		for i in [0..10]
			@spawnZombie()
		
	spawnZombie: ->
		location = @randomLocation()
		zombie = new Zombie location.x, location.y
		@zombies.push zombie

	updateZombies: ->
		# Update the zombies
		for zombie in @zombies
			delta =
				x: Math.abs @player.pos.x - zombie.pos.x
				y: Math.abs @player.pos.y - zombie.pos.y


			if delta.x > delta.y
				if @player.pos.x > zombie.pos.x then zombie.pos.x++
				else if @player.pos.x < zombie.pos.x then zombie.pos.x--
			else
				if @player.pos.y > zombie.pos.y then zombie.pos.y++
				else if @player.pos.y < zombie.pos.y then zombie.pos.y--

			if (delta.x == 1 and delta.y == 0) or (delta.x == 0 and delta.y == 1)
				zombie.attack @player

	completedTurn: ->
		@updateZombies()

			
		


module.exports = World