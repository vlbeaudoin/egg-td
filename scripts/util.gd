extends Node2D

## VARS
enum GameModes { 
	BUILD, # Between waves
	WAVE, # During waves
}
enum Cells {
	INVALID = -10,
	EMPTY = -1,
	GRASS = 0,
	FENCE = 1,
	DIRT = 2,
	NESTBOX = 3,
}

enum Costs {
	FENCE = 5
}

var selected_cell: Cell
var grabbed_chicken
var game_mode: int = GameModes.BUILD
var total_mobs: int
var timer_wave_end = Timer.new()
var timer_game_end = Timer.new()
var selected_building: int

var inv = { "white_eggs" : Costs.FENCE * 10 , "green_eggs" : 0, "red_eggs" : 0} as Dictionary
var base_health = 25

onready var player_buildings = $"/root/main/player_buildings" as TileMap

onready var astar_nav = $"/root/main/astar_nav" as Node2D
onready var mob_spawn = $"/root/main/mob_spawn" as Node2D

onready var selection = $"/root/main/selection" as Sprite

onready var menu_pause = $"/root/main/CanvasLayer/menu_pause" as Popup
onready var victory_popup = $"/root/main/CanvasLayer/victory_popup" as Popup

onready var btn_start_wave = $"/root/main/CanvasLayer/ui-background/btn_start_wave" as TextureButton
onready var btn_pause = $"/root/main/CanvasLayer/ui-background/btn_pause" as TextureButton
onready var build_empty = $"/root/main/CanvasLayer/ui-background/build_empty" as TextureButton
onready var build_fence = $"/root/main/CanvasLayer/ui-background/build_fence" as TextureButton
onready var label_white_eggs = $"/root/main/CanvasLayer/ui-background/sprite_white_egg/label_white_eggs" as Label
onready var label_base_health = $"/root/main/CanvasLayer/ui-background/sprite_base_health/label_base_health" as Label
onready var label_wave = $"/root/main/ColorRect2/label_wave"
onready var chickens = get_tree().get_nodes_in_group("chickens")


## FUNCS
func enter_state(new_game_mode: int):
	if not new_game_mode == game_mode:
		match new_game_mode:
			GameModes.BUILD:
				game_mode = GameModes.BUILD
				astar_nav.shimmer = true
				for chicken in chickens:
					chicken.eggs_timer.stop()
				MusicPlayer.fade_music(0)
			GameModes.WAVE:
				game_mode = GameModes.WAVE
				astar_nav.shimmer = false
				MusicPlayer.fade_music(1)

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
		
#		# Selection visibility
#		 selection.visible = not grabbed_chicken == null

func unpress_buttons():
	build_empty.pressed = false
	build_fence.pressed = false

func _handle_eggs_display():
	inv.white_eggs = clamp(inv.white_eggs, 0, INF)
	
	if inv.white_eggs <= 9000:
		label_white_eggs.text = str(inv.white_eggs)
	else:
		label_white_eggs.text = "9000+"

func _handle_health_display():
	if base_health <= 0:
		get_tree().change_scene("res://scenes/game_over.tscn")
	else:
		label_base_health.text = str(base_health)

## SIGNALS
func _on_btn_start_pressed():
	if game_mode == GameModes.BUILD:
		unpress_buttons()
		mob_spawn.start_wave()
		SFXPlayer.play_sfx("warning")
		
func _on_btn_pause_pressed():
	unpress_buttons()
	menu_pause.switch_pause()

func _on_mob_spawn_wave_ended():
	timer_wave_end.start(1)

func _on_mob_spawn_game_ended():
	timer_game_end.start(1)

func _on_timer_wave_end_timeout():
	if total_mobs == 0:
		enter_state(GameModes.BUILD)
		timer_wave_end.stop()
		if not mob_spawn.waves.empty():
			label_wave.text = mob_spawn.waves[0].description
			
func _on_timer_game_end_timeout():
	if total_mobs == 0:
		enter_state(GameModes.BUILD)
		timer_game_end.stop()
		victory_popup.popup()

func _on_build_empty_toggled(button_pressed):
	if button_pressed:
		if build_fence.pressed:
			build_fence.pressed = false
		selected_building = Cells.EMPTY
		
	elif not build_fence.pressed:
		selected_building = Cells.INVALID
	
func _on_build_fence_toggled(button_pressed):
	if button_pressed:
		if build_empty.pressed:
			build_empty.pressed = false
		selected_building = Cells.FENCE
		
	elif not build_empty.pressed:
		selected_building = Cells.INVALID


## SETGET


## EXECUTION
func _ready():
	btn_start_wave.connect("pressed", self, "_on_btn_start_pressed")
	btn_pause.connect("pressed", self, "_on_btn_pause_pressed")
	mob_spawn.connect("wave_ended", self, "_on_mob_spawn_wave_ended")
	mob_spawn.connect("game_ended", self, "_on_mob_spawn_game_ended")
	
	build_empty.connect("toggled", self, "_on_build_empty_toggled")
	build_fence.connect("toggled", self, "_on_build_fence_toggled")
	
	timer_wave_end.connect("timeout", self, "_on_timer_wave_end_timeout")
	timer_game_end.connect("timeout", self, "_on_timer_game_end_timeout")
	add_child(timer_wave_end)
	add_child(timer_game_end)
	
	MusicPlayer.set_dynamic(0)
	
	if not mob_spawn.waves.empty():
			label_wave.text = mob_spawn.waves[0].description

func _process(_delta):
	_handle_input()
	_update_selected_cell()
	_handle_selection()
	total_mobs = get_tree().get_nodes_in_group("mobs").size()
	_handle_eggs_display()
	_handle_health_display()
