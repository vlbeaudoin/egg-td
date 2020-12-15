extends AStarPath

## VARS
onready var mob = get_parent()
onready var last_point = mob.global_position

onready var start_position = reference_tilemap.world_to_map($"/root/main/start_position".position)
onready var end_position = reference_tilemap.world_to_map($"/root/main/end_position".position)


## DBG
var velocity = Vector2()
var speed = 50

## FUNCS

	
func move_along_path(distance):
	var last_point = mob.global_position
	
	while path.size():
		var next_point = reference_tilemap.map_to_world(path[0])
		var distance_between_points = last_point.distance_to(next_point)
		
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			mob.global_position = last_point.linear_interpolate(next_point, distance / distance_between_points)
			return
		
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = reference_tilemap.map_to_world(path[0])
		
		path.remove(0)


## SIGNALS


## SETGET


## EXECUTION

func _ready():
	_get_path(start_position, end_position)

func _process(delta):
	move_along_path(speed * delta)

