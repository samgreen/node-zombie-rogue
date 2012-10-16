World = require '../world'
TerminalClient = require '../terminal_client'

gameOptions =
	file: 'levels/farm.json'
gameWorld = new World gameOptions
client = new TerminalClient gameWorld