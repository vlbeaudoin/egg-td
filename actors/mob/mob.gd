class_name mob_base
extends KinematicBody2D

## VARS
export var mob_type = "base"

# References
onready var screen_size = get_viewport_rect().size
onready var mob_navigation = $mob_navigation as Node2D
onready var health_bar = $health_bar as TextureProgress
onready var astar_nav = $"/root/main/astar_nav" as AStarPath
onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var sprite = $Sprite as Sprite
onready var collision_shape = $CollisionShape2D as CollisionShape2D

export(int) var max_health = 3
export(int) var health = max_health
export(float) var speed = 30
var distance setget , get_distance
#export(int) var hunger = 1

#var looking_left = false

## FUNCS
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
func get_distance():
	return mob_navigation.total_path_distance


## EXECUTION
func _ready():
	add_to_group("mobs")
	health_bar.max_value = max_health
	health_bar.value = health
#	health_bar.z_index = 1

func _process(_delta):
	health_bar.value = health
	
	if mob_navigation and mob_navigation.path:
		var next_cell = mob_navigation.path[0]
		
		var next_cell_pos = player_buildings.map_to_world(next_cell)
		var mob_pos = global_position
		
		if not next_cell_pos.y == mob_pos.y:
			sprite.flip_h = next_cell_pos.x > mob_pos.x
#			sprite.flip_h = true
#		else:
#			sprite.flip_h = false
#		print()
#		sprite.flip_h = player_buildings.map_to_world(next_cell).x < 
	

