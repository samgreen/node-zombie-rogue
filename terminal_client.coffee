Charm = require 'charm'

SYMBOL_MAP =
	0: '░'
	1: '+'
	2: '#'
	3: '▁'
	4: '^'
	5: '*'
	'░': '░'
	'▛': '▛'
	'▀': '▀'
	'▜': '▜'
	'▌': '▌'
	'▐': '▐'
	'▙': '▙'
	'▄': '▄'
	'▟': '▟'
	Z: 'Z'
	P: '@'

COLOR_MAP =
	'▛': 
		fore: 'white'
		back: 'green'
	'▀': 
		fore: 'white'
		back: 'green'
	'▜': 
		fore: 'white'
		back: 'green'
	'▌': 
		fore: 'white'
		back: 'green'
	'▐': 
		fore: 'white'
		back: 'green'
	'▙': 
		fore: 'white'
		back: 'green'
	'▄': 
		fore: 'white'
		back: 'green'
	'▟': 
		fore: 'white'
		back: 'green'
	'░':
		fore: 'white'
		back: 'green'
	0: 
		fore: 'white'
		back: 'green'
	1:
		fore: 'white'
		back: 'green'
	2:
		fore: 'white'
		back: 'black'
	3:
		fore: 'white'
		back: 'green'
	4:
		fore: 'white'
		back: 'green'
	5:
		fore: 'white'
		back: 'green'
	Z:
		fore: 'red'
		back: 'black'
	P:
		fore: 'yellow'
		back: 'black'

INPUT =
	UP: 65
	DOWN: 66
	RIGHT: 67
	LEFT: 68

class TerminalClient
	constructor: (@world) ->
		@charm = new Charm process
		@charm.on '^C', process.exit
		@charm.cursor false

		@mapOffset =
			x: 0
			y: 0

		process.stdin.on 'data', @handleInput

		@redraw()

	handleInput: (chunk) =>
		startPos = 
			x: @world.player.pos.x
			y: @world.player.pos.y

		keycode = chunk[2]
		if keycode == INPUT.UP
			@world.player.pos.y--
		else if keycode == INPUT.DOWN
			@world.player.pos.y++
		else if keycode == INPUT.LEFT
			@world.player.pos.x--
		else if keycode == INPUT.RIGHT
			@world.player.pos.x++

		unless @world.player.pos.x == startPos.x and @world.player.pos.y == startPos.y
			# Draw the previous contents in this space
			# @redraw startPos.x, startPos.y
			# Redraw the player
			# @drawPlayer()
			@world.completedTurn()
			@redraw()

	redraw: (tileX, tileY) ->
		unless tileX and tileY
			@drawWorld()
			@drawZombies()
			@drawPlayer()
		else
			pos =
				x: tileX
				y: tileY
			mapValue = @world.mapData[pos.x][pos.y]
			@writeMappedSymbol mapValue, pos

		@drawStats()

	drawWorld: ->
		map = @world.mapData
		for col, y in map
			for mapValue, x in col
				pos =
					x: x
					y: y
				@writeMappedSymbol mapValue, pos

	drawZombies: ->
		zombies = @world.zombies
		for zombie in zombies
			@writeMappedSymbol 'Z', zombie.pos

	drawStats: ->
		x = 0
		player = @world.player
		nameString = "Name: #{ player.name } "

		@charm.position x, @world.size.y + 1
		# @charm.erase 'line'

		@charm.background 'black'
		@charm.foreground 'white'
		@charm.write nameString
		x += nameString.length

		healthString = " Health: #{ player.health } "
		@charm.position @world.size.x - healthString.length + 1, @world.size.y + 1
		@charm.foreground 'red'
		@charm.background 'black'
		@charm.write healthString
		# x += healthString.length

	drawPlayer: (pos=@world.player.pos) ->
		@charm.display 'bright'
		@writeSymbol '@', pos, 'yellow', @getBackgroundColor(@world.mapData[pos.x][pos.y])
		@charm.display 'reset'

	getSymbol: (mapValue) ->
		SYMBOL_MAP[mapValue]

	getBackgroundColor: (mapValue) ->
		COLOR_MAP[mapValue].back

	getForegroundColor: (mapValue) ->
		COLOR_MAP[mapValue].fore

	writeMappedSymbol: (mapValue, pos) ->
		symbol = @getSymbol mapValue
		fore = @getForegroundColor mapValue
		back = @getBackgroundColor mapValue

		@writeSymbol symbol, pos, fore, back

	writeSymbol: (symbol, pos, foreground, background) ->
		@charm.position pos.x + @mapOffset.x, pos.y + @mapOffset.y
		@charm.background background
		@charm.foreground foreground
		@charm.write symbol		
		

module.exports = TerminalClient