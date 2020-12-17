extends Node2D

## VARS
var selected_cell: Cell
var grabbed_chicken

onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var menu_pause = $"/root/main/CanvasLayer/menu_pause" as Popup

## FUNCS
func _handle_input():
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://scenes/main.tscn")
		
	if Input.is_action_just_released("click"):
		if grabbed_chicken:
			grabbed_chicken.release() #TODO make this do stuff
	
	
		

func _update_selected_cell():
	# Obtain cursor position
	
	
	## Cell at cursor
	
	
	var cell_position = player_buildings.world_to_map(get_global_mouse_position()) as Vector2
	var cell_id = player_buildings.get_cell(cell_position.x, cell_position.y)
	
	selected_cell = Cell.new(cell_id, cell_position)
	
	
#	var cell_name: String
#
#	match cell_id:
#		-1: cell_name = "Empty"
#		0: cell_name = "Grass"
#		1: cell_name = "fence"
#		2: cell_name = "dirt"
#		3: cell_name = "platform_base" # "tower"
#		4: cell_name = "chicken-placeholder"
#
#	debug_message += \
#		"""
#		Cell: %s
#		Cell_id: %s
#		Cell_name: %s
#		""" % [Util.selected.cursor_pos, cell_id, cell_name]

## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass

func _process(_delta):
	_handle_input()
	_update_selected_cell()
