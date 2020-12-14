class_name mob_base
extends KinematicBody2D

## VARS
export var mob_type = "base" setget , get_mob_type

onready var mob_navigation = $mob_navigation
onready var health_bar = $health_bar


# Movement
var velocity = Vector2()
export var speed = 0.5 setget , get_speed
var distance setget , get_distance
#export var acceleration
#export var friction

# Stats
var max_health = 5
var health = max_health setget , get_health

# References
onready var screen_size = get_viewport_rect().size


## FUNCS
func process_movement():
	move_and_slide(velocity * speed)

func clamp_position():
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func hurt(damage: int):
	health -= damage
	if health < 1:
		kill()

func kill():
	#TODO drop stuff sometimes
	#TODO +1 to mobs_killed
	#TODO play death animation
	queue_free()
	
## SIGNALS


## SETGET
func get_mob_type():
	return mob_type

func get_speed():
	return speed

func get_distance():
	return mob_navigation.get_total_path_distance()

func get_health():
	return health

## EXECUTION
func _ready():
#	velocity = Vector2.LEFT # [dbg] make the mob go left
	add_to_group("mobs")
	health_bar.max_value = max_health
	health_bar.value = health

func _process(delta):
	health_bar.value = health

func _physics_process(delta):
	pass
#	process_movement()
#	clamp_position() # should be left after process_movement
