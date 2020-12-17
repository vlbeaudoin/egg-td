extends Node2D

## VARS
var selected_cell: Cell
var grabbed_chicken

onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var menu_pause = $"/root/main/CanvasLayer/menu_pause" as Popup
onready var astar_nav = $"/root/main/astar_nav"



enum GameMode { 
	BUILD, # Between waves
	WAVE, # During waves
}

var game_mode: int

## FUNCS
func enter_state(new_game_mode: int):
	if not new_game_mode == game_mode:
		match new_game_mode:
			GameMode.BUILD:
				game_mode = GameMode.BUILD
				astar_nav.shimmer(false)
				#TODO show shimmers along the path
				#TODO allow building
			GameMode.WAVE:
				game_mode = GameMode.WAVE
				astar_nav.shimmer(true)
				#TODO hide shimmers along the path
				#TODO prevent building

func _handle_input():
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://scenes/main.tscn")
		
	if Input.is_action_just_released("click"):
		if grabbed_chicken:
			grabbed_chicken.release() #TODO make this do stuff
	
	if Input.is_action_just_pressed("ui_left"):
		if astar_nav:
			astar_nav.shimmer = false
	
	if Input.is_action_just_pressed("ui_right"):
		if astar_nav:
			astar_nav.shimmer = true
	

func _update_selected_cell():
	if player_buildings:
		# Obtain cursor position
		var cell_position = player_buildings.world_to_map(get_global_mouse_position()) as Vector2
		var cell_id = player_buildings.get_cell(cell_position.x, cell_position.y)
	
		selected_cell = Cell.new(cell_id, cell_position)
		

## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass

func _process(_delta):
	_handle_input()
	_update_selected_cell()
