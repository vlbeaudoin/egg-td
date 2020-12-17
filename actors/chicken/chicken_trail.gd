extends Area2D
# This node serves as a basis for dragging and dropping the chicken around

## VARS
var chicken_ghost_res = load("res://actors/chicken/chicken_ghost.tscn")

var ghost: Node2D

onready var chicken = get_parent()

## FUNCS
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.get_button_index() == 1:
		if event.is_pressed():
			Util.grabbed_chicken = chicken
			ghost = chicken_ghost_res.instance()
			add_child(ghost)
			ghost.z_index = 1
			ghost.set_origin_chicken(chicken)
			
	
func handle_grabbed_chicken_dropped():
	Util.grabbed_chicken = null
	ghost.trail.queue_free()
	ghost.queue_free()
	#TODO check if it is possible to place the chicken in selected_cell


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

#func _process():
#	handle_grabbed_chicken_dropped()
