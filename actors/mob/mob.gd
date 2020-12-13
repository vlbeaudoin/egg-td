class_name mob_base
extends KinematicBody2D

## VARS
export var mob_type = "base" setget , get_mob_type

onready var mob_navigation = $mob_navigation

# Movement
var velocity = Vector2()
export var speed = 0.5 setget , get_speed
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

func get_speed():
	return speed

func get_distance():
	return mob_navigation.get_total_path_distance()

## EXECUTION
func _ready():
	velocity = Vector2.LEFT # [dbg] make the mob go left
	add_to_group("mob")

func _physics_process(delta):
	pass
#	process_movement()
#	clamp_position() # should be left after process_movement
