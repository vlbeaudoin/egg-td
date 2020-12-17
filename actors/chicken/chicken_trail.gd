extends Area2D
# This node serves as a basis for dragging and dropping the chicken around

## VARS
var chicken_ghost_res = load("res://actors/chicken/chicken_ghost.tscn")

var ghost

onready var tilemap = $"/root/main/tilemap_buildings"
onready var chicken = get_parent()

## FUNCS
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.get_button_index() == 1:
		if event.is_pressed():
			Util.grabbed_chicken = chicken
			ghost = chicken_ghost_res.instance() as Node2D
			add_child(ghost)
			
			ghost.z_index = 1
			
			ghost.set_origin_chicken(chicken)
#		else:
			
	
func handle_grabbed_chicken_dropped():
#	if Input.is_action_just_released("click")
	Util.grabbed_chicken = null
	
#	print(Util.)
	
	print()
	
	ghost.trail.queue_free()
	ghost.queue_free()

#TODO clear selected in util

#func _input(event):
#	if event is InputEventMouseButton and event.get_button_index() == 1:
##		if tilemap.world_to_map(get_viewport().get_mouse_position()) == tilemap.world_to_map(chicken.global_position):
#
##			if event.is_pressed() and get_viewport().get_mouse_position():
#			if event.is_pressed():
#				if get_global_mouse_position() == tilemap.world_to_map(chicken.global_position):
#					# Grab chicken
#					ghost = chicken_ghost_res.instance()
#					add_child(ghost)
#					ghost.set_origin_chicken(chicken)
#			elif ghost:
#				ghost.trail.queue_free()
#				ghost.queue_free()
		
		# Release grabbed chicken
		
		#TODO attempt to place chicken in building

#func 

## SIGNALS
func _on_mouse_entered():
	if not Util.selected_cell:
		Util.selected_cell = chicken
	
func _on_mouse_exited():
	if Util.selected_cell == chicken:
		Util.selected_cell = null
	
## SETGET


## EXECUTION
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("input_event", self, "_on_input_event")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

#func _process():
#	handle_grabbed_chicken_dropped()
