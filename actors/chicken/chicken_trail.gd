extends Area2D
# This node serves as a basis for dragging and dropping the chicken around

## VARS
const DEBUG = true
var chicken_ghost_res = load("res://actors/chicken/chicken_ghost.tscn")

var ghost: Node2D

onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var chicken = get_parent()
#onready var chickens = get_tree().get_nodes_in_group("chicken")

## FUNCS
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.get_button_index() == 1:
		if event.is_pressed():
			Util.grabbed_chicken = chicken
			ghost = chicken_ghost_res.instance()
			add_child(ghost)
			ghost.z_index = 2
			ghost.set_origin_chicken(chicken)
			
	
func handle_grabbed_chicken_dropped():
	var cell = Util.selected_cell
	
	
	if cell.id == 3:
#		print("Building found!")
	
#	if not chicken.current_cell:
		
		
		if cell.coordinates == chicken.current_cell.coordinates:
			if DEBUG:
				print("[dbg] Already at destination.")
#		else:
		else:
			var occupied = false
			var chickens = get_tree().get_nodes_in_group("chickens")
			
			if not chickens:
				if DEBUG:
					print("[dbg] No chickens were found in \"chickens\" node group, this is weird and bad.")
			else:
				for other_chicken in chickens:
#					print(other_chicken)
					if other_chicken.current_cell.coordinates == cell.coordinates:
						occupied = true
				
				if not occupied:
					if DEBUG:
						print("[dbg] Moving {%s} to %s." % [chicken, cell.coordinates])
					chicken.current_cell.id = cell.id as int
					chicken.current_cell.coordinates = cell.coordinates as Vector2
					chicken.move_to(cell)
				
				
				else:
					if DEBUG:
						print("[dbg] Building already occupied.")
	
	# Cleanup
	Util.grabbed_chicken = null
	ghost.trail.queue_free()
	ghost.queue_free()

func handle_ghost_visibility():
	if ghost:
		var ghost_position = player_buildings.world_to_map(ghost.global_position)
		var chicken_position = player_buildings.world_to_map(chicken.global_position)
		
		if ghost_position == chicken_position:
			ghost.visible = false
			ghost.trail.visible = false
		else:
			ghost.visible = true
			ghost.trail.visible = true
## SIGNALS
#func _on_mouse_entered():
#	if not Util.selected_cell:
#		Util.selected_cell = chicken
#
#func _on_mouse_exited():
#	if Util.selected_cell == chicken:
#		Util.selected_cell = null
	
## SETGET


## EXECUTION
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "_on_input_event")
#	connect("mouse_entered", self, "_on_mouse_entered")
#	connect("mouse_exited", self, "_on_mouse_exited")

func _process(_delta):
#	handle_grabbed_chicken_dropped()
	handle_ghost_visibility()
