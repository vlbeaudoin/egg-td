extends Node2D

## VARS
var selected
var grabbed_chicken

onready var tilemap = $"/root/main/tilemap_buildings"
onready var menu_pause = $"/root/main/CanvasLayer/menu_pause"

## FUNCS
func _handle_input():
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://scenes/main.tscn")
		
	if Input.is_action_just_released("click"):
		if grabbed_chicken:
			grabbed_chicken.release() #TODO make this do stuff
	
	
		

func _update_selected():
	# Obtain cursor position
	var cursor_pos = tilemap.world_to_map(get_viewport().get_mouse_position())
	
	## Cell at cursor
	var cell_id = tilemap.get_cell(cursor_pos.x, cursor_pos.y)
	var cell_name: String
	
	match cell_id:
		-1: cell_name = "Empty"
		0: cell_name = "Grass"
		1: cell_name = "fence"
		2: cell_name = "dirt"
		3: cell_name = "platform_base" # "tower"
		4: cell_name = "chicken-placeholder"
		
	return 
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
