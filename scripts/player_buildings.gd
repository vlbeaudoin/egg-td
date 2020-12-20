extends TileMap

## VARS
const DEBUG = true

onready var util = $"/root/main/util"
onready var zone_build = $"/root/main/zone_build" as TileMap
onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var astar_nav = $"/root/main/astar_nav"



## FUNCS
func _handle_building():
	if util.game_mode == util.GameModes.BUILD and util.selected_building and not util.selected_building == -10 and not util.grabbed_chicken:
		var old_cell = Cell.new(util.selected_cell.id, util.selected_cell.coordinates)
		var new_cell = Cell.new(util.selected_building, util.selected_cell.coordinates)
		
		
		if Input.is_action_pressed("click") \
			and not zone_build.get_cellv(util.selected_cell.coordinates) == -1 \
			and not old_cell.id == new_cell.id:
			
			match new_cell.id:
				util.Cells.EMPTY:
					if old_cell.id == util.Cells.FENCE:
						player_buildings.set_cellv(new_cell.coordinates, new_cell.id)
						player_buildings.update()
						astar_nav.update_astar()

						var test_path = astar_nav.try_path(astar_nav.start_position, astar_nav.end_position) as PoolVector2Array
						
						if not test_path:
							player_buildings.set_cellv(old_cell.coordinates, old_cell.id)
							player_buildings.update()
							astar_nav.update_astar()
						else:
							astar_nav.path = test_path
							util.inv.white_eggs += util.Costs.FENCE
							SFXPlayer.sfx_dig(new_cell.coordinates * cell_size)
						
						
						astar_nav.update_path_shimmer()
						
						
				
				util.Cells.FENCE:
					if old_cell.id == util.Cells.EMPTY and util.inv.white_eggs >= util.Costs.FENCE:
						# try new path
						player_buildings.set_cellv(new_cell.coordinates, new_cell.id)
						player_buildings.update()
						astar_nav.update_astar()
						
						var test_path = astar_nav.try_path(astar_nav.start_position, astar_nav.end_position) as PoolVector2Array
						
						if not test_path:
							player_buildings.set_cellv(old_cell.coordinates, old_cell.id)
							player_buildings.update()
							astar_nav.update_astar()
						else:
							astar_nav.path = test_path
							astar_nav.update_path_shimmer()
							util.inv.white_eggs -= util.Costs.FENCE
							SFXPlayer.sfx_knock(new_cell.coordinates * cell_size)
			
			player_buildings.update_bitmask_area(new_cell.coordinates)

#			if not old_cell == new_cell:
#			player_buildings.set_cellv(new_cell.coordinates, new_cell.id)
			
#			player_buildings.update()
			
#			astar_nav.update_astar()
			
#			var test_path = astar_nav.try_path(astar_nav.start_position, astar_nav.end_position) as PoolVector2Array
			
			
#			if not test_path:
#				player_buildings.set_cellv(old_cell.coordinates, old_cell.id)
#				player_buildings.update()
#				astar_nav.update_astar()
#			else:
#				astar_nav.path = test_path
#				astar_nav.update_path_shimmer()
			
#			player_buildings.update_bitmask_area(new_cell.coordinates)
#				if test_path:
#				match util.selected_building:
#					util.Cells.FENCE:
#						if util.inv.white_eggs >= util.Costs.FENCE:
#							astar_nav.path = test_path
#							astar_nav.update_path_shimmer()
#							util.inv.white_eggs -= util.Costs.FENCE
#
#					util.Cells.EMPTY:
#						pass
			
			
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
