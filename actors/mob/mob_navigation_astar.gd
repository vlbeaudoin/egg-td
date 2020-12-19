extends Node

## VARS
onready var astar_nav = $"/root/main/astar_nav" as AStarPath
onready var end_position = $"/root/main/end_position" as Position2D
onready var player_buildings = $"/root/main/player_buildings" as TileMap
onready var path = astar_nav.path as PoolVector2Array


onready var mob = get_parent()
onready var last_point = mob.global_position as Vector2


var total_path_distance


## FUNCS
func move_along_path(distance):
	last_point = mob.global_position

	while path.size():
		var next_point = astar_nav.zone_path.map_to_world(path[0])
		var distance_between_points = last_point.distance_to(next_point)

		# The position to move to falls between two points.
		if distance <= distance_between_points:
			mob.global_position = last_point.linear_interpolate(next_point, \
				distance / distance_between_points)
			return

		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = astar_nav.zone_path.map_to_world(path[0])

		path.remove(0)


func calculate_total_path_distance():
	if path.size() > 0:
		var distance = 0.0

		var mob_position = mob.global_position

		distance += astar_nav.zone_path.map_to_world(path[0]).distance_to(mob_position)

		for index in range(path.size()):
			if index != 0:
				distance += astar_nav.zone_path.map_to_world(path[index]).distance_to(astar_nav.zone_path.map_to_world(path[index-1]))

		return distance

## SIGNALS


## SETGET


## EXECUTION
func _process(delta):
	total_path_distance = calculate_total_path_distance()
	move_along_path(mob.speed * delta)
	
	if player_buildings.world_to_map(mob.global_position) == player_buildings.world_to_map(end_position.global_position):
		mob.queue_free()
