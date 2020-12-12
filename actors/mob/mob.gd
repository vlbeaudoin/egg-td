class_name mob_base
extends KinematicBody2D

## VARS
export var mob_type = "base" setget , get_mob_type

# Movement
var velocity = Vector2()
export var speed = 30
#export var acceleration
#export var friction

# References
onready var screen_size = get_viewport_rect().size


## FUNCS
func process_movement():
	move_and_slide(velocity * speed)

func clamp_position():
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
## SIGNALS


## SETGET
func get_mob_type():
	return mob_type

## EXECUTION
func _ready():
	velocity = Vector2.LEFT # [dbg] make the mob go left
	add_to_group("mob")

func _physics_process(delta):
	process_movement()
	clamp_position() # should be left after process_movement
