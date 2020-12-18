extends TileMap

## VARS
const DEBUG = true

onready var util = $"/root/main/util"
onready var zone_build = $"/root/main/zone_build" as TileMap
onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var astar_nav = $"/root/main/astar_nav"



## FUNCS
func _handle_building():
	if util.game_mode == util.GameModes.BUILD and util.selected_building:
		if Input.is_action_just_released("click") and not zone_build.get_cellv(util.selected_cell.coordinates) == -1:
			
			
			## TODO fix this whole section (and the relative functions in AStarPath
			var test_path = astar_nav.try_path(astar_nav.start_position, astar_nav.end_position)
			
			if test_path:
				player_buildings.set_cellv(util.selected_cell.coordinates, util.selected_building)
			else:
				if DEBUG:
					print("[dbg] Path invalid.")
					#TODO play a sound or something idk
					
			

## SIGNALS



## SETGET


## EXECUTION
func _ready():
	pass

func _process(_delta):
	_handle_building()

## Cells reference
#			-1: cell_name = "Empty"
#			0: cell_name = "Grass"
#			1: cell_name = "fence"
#			2: cell_name = "dirt"
#			3: cell_name = "platform_base" # "tower"
#			4: cell_name = "chicken-placeholder"
