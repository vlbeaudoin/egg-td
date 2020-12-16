extends Node

## VARS
onready var mob = get_parent() # is the mob
onready var last_point = mob.global_position # needed for mob

onready var astar_nav = $"/root/main/astar_nav"

onready var path = astar_nav.path
#onready var astar_nav = $"/root/AstarNav"

## FUNCS
func move_along_path(distance):
	last_point = mob.global_position

	while path.size():
#	while path.size():
#		var next_point = tilemap_ground.map_to_world(path[0])
		var next_point = astar_nav.tilemap_ground.map_to_world(path[0])
		var distance_between_points = last_point.distance_to(next_point)

		# The position to move to falls between two points.
		if distance <= distance_between_points:
			mob.global_position = last_point.linear_interpolate(next_point, \
				distance / distance_between_points)
			return

		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = astar_nav.tilemap_ground.map_to_world(path[0])

		path.remove(0)


func get_total_path_distance():
	if path.size() > 0:
		var distance = 0.0

		var mob_position = mob.global_position

		distance += astar_nav.tilemap_ground.map_to_world(path[0]).distance_to(mob_position)

		for index in range(path.size()):
			if index != 0:
				distance += astar_nav.tilemap_ground.map_to_world(path[index]).distance_to(astar_nav.tilemap_ground.map_to_world(path[index-1]))

		return distance
	else:
		# path is empty
		pass

## SIGNALS


## SETGET


## EXECUTION
func _process(delta):
#	if path:
	move_along_path(mob.speed * delta)
#	else:
#		return
