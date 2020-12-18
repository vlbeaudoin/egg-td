extends Node2D

## VARS
enum GameModes { 
	BUILD, # Between waves
	WAVE, # During waves
}
enum Cells {
	EMPTY = -1,
	GRASS = 0,
	FENCE = 1,
	DIRT = 2,
	TOWER = 3,
}

var selected_cell: Cell
var grabbed_chicken
var game_mode: int = GameModes.BUILD
var total_mobs: int
var timer_wave_end = Timer.new()
var selected_building: int

onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var menu_pause = $"/root/main/CanvasLayer/menu_pause" as Popup
onready var astar_nav = $"/root/main/astar_nav" as Node2D
#onready var util = $"/root/main/util"
onready var selection = $"/root/main/selection" as Sprite
#onready var check_game_mode = $"/root/main/CanvasLayer/check_game_mode" as CheckButton 
onready var btn_start_wave = $"/root/main/CanvasLayer/btn_start_wave" as TextureButton
onready var btn_pause = $"/root/main/CanvasLayer/btn_pause" as TextureButton
onready var mob_spawn = $"/root/main/mob_spawn" as Node2D
onready var build_tower = $"/root/main/CanvasLayer/build_tower" as TextureButton
onready var build_fence = $"/root/main/CanvasLayer/build_fence" as TextureButton


## FUNCS
func enter_state(new_game_mode: int):
	if not new_game_mode == game_mode:
		match new_game_mode:
			GameModes.BUILD:
				game_mode = GameModes.BUILD
				astar_nav.shimmer = true
				#TODO allow building
			GameModes.WAVE:
				game_mode = GameModes.WAVE
				astar_nav.shimmer = false
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
		var cell_position = player_buildings.world_to_map(get_global_mouse_position()) as Vector2
		var cell_id = player_buildings.get_cell(cell_position.x, cell_position.y)
	
		selected_cell = Cell.new(cell_id, cell_position)
	

func _handle_selection():
	if selection:
		
		if selected_cell:
			selection.global_position = player_buildings.map_to_world(selected_cell.coordinates)
		
		# Selection visibility
#		selection.visible = not grabbed_chicken == null #

## SIGNALS

func _on_btn_start_pressed():
	if game_mode == GameModes.BUILD:
		mob_spawn.start_wave()
		
func _on_btn_pause_pressed():
		menu_pause.switch_pause()

func _on_mob_spawn_wave_ended():
	timer_wave_end.start(1)

func _on_timer_wave_end_timeout():
	if total_mobs == 0:
		enter_state(GameModes.BUILD)
		timer_wave_end.stop()

func _on_build_tower_pressed():
	selected_building = Cells.TOWER
	
func _on_build_fence_pressed():
	selected_building = Cells.FENCE
## SETGET


## EXECUTION
func _ready():
	btn_start_wave.connect("pressed", self, "_on_btn_start_pressed")
	btn_pause.connect("pressed", self, "_on_btn_pause_pressed")
	mob_spawn.connect("wave_ended", self, "_on_mob_spawn_wave_ended")
	build_tower.connect("pressed", self, "_on_build_tower_pressed")
	build_fence.connect("pressed", self, "_on_build_fence_pressed")
	
	timer_wave_end.connect("timeout", self, "_on_timer_wave_end_timeout")
	add_child(timer_wave_end)

func _process(_delta):
	_handle_input()
	_update_selected_cell()
	_handle_selection()
	total_mobs = get_tree().get_nodes_in_group("mobs").size()
