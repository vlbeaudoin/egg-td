extends Node2D
## TODO put this stuff somewhere in util


## VARS
#onready var tilemap_buildings = $"/root/main/tilemap_buildings" as TileMap
onready var player_buildings = $"/root/main/player_buildings" as TileMap

enum GameMode { 
	BUILD, # Between waves
	WAVE # During waves
}

var state: int

## FUNCS

## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass
