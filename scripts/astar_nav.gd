extends AStarPath

## VARS
#onready var mob = get_parent() # is the mob
#onready var last_point = mob.global_position # needed for mob

onready var start_position = tilemap_ground.world_to_map($"/root/main/start_position".global_position)
onready var end_position = tilemap_ground.world_to_map($"/root/main/end_position".global_position)


## DBG
#var velocity = Vector2()
#var speed = 50

## FUNCS

	
#func move_along_path(distance):
#	last_point = mob.global_position
#
#	while path.size():
#		var next_point = tilemap_ground.map_to_world(path[0])
#		var distance_between_points = last_point.distance_to(next_point)
#
#		# The position to move to falls between two points.
#		if distance <= distance_between_points:
#			mob.global_position = last_point.linear_interpolate(next_point, \
#				distance / distance_between_points)
#			return
#
#		# The position is past the end of the segment.
#		distance -= distance_between_points
#		last_point = tilemap_ground.map_to_world(path[0])
#
#		path.remove(0)
#
#
#func get_total_path_distance():
#	if path.size() > 0:
#		var distance = 0.0
#
#		var mob_position = mob.global_position
#
#		distance += tilemap_ground.map_to_world(path[0]).distance_to(mob_position)
#
#		for index in range(path.size()):
#			if index != 0:
#				distance += tilemap_ground.map_to_world(path[index]).distance_to(tilemap_ground.map_to_world(path[index-1]))
#
#		return distance
#	else:
#		# path is empty
#		pass

## SIGNALS


## SETGET


## EXECUTION

func _ready():
	#TODO change this thing to obtain path from a central astar_nav, and move the movement stuff to a new mob_navigation
	_calculate_path(start_position, end_position)  
	# get_path(astar_nav) #TODO 
	
	#TODO clear path and run _get_path() when player modifies the board. 
	#If there is no available path, remove the building.

#func _process(delta):
##	if path:
#	move_along_path(mob.speed * delta)
##	else:
##		return

