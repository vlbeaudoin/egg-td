extends Node2D
## TODO put this stuff somewhere in Util


## VARS
onready var tilemap_buildings = $"/root/main/tilemap_buildings" as TileMap

enum GameMode { 
	BUILD, # Between waves
	WAVE # During waves
}

var state: int

## FUNCS
func enter_state(new_state: int):
	if not new_state == state:
		match state:
			GameMode.BUILD:
				state = GameMode.BUILD
			GameMode.WAVE:
				state = GameMode.WAVE
## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass
