extends Node2D

## VARS
enum {
	IDLE,
	RUN,
	NEST,
	TOWER
}

var state = IDLE setget , get_state

var destination = Vector2()
var mob_navigation

## FUNCS
func enter_state(new_state):
	match new_state:
		IDLE:
			state = IDLE
			#TODO set chicken animation to idle
			#
		RUN:
			state = RUN
			#TODO set chicken animation to run
			get_parent().look_at(destination)
		NEST:
			state = NEST
			
		TOWER:	
			state = TOWER
## SIGNALS


## SETGET
func get_state():
	return state

#func get_total_path_distance():
#	pass

## EXECUTION
func _ready():
	pass
