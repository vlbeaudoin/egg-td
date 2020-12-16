extends Node2D

## VARS
onready var mob = get_parent()

var path = []

## FUNC
func move_along_path(distance):
	var last_point = mob.global_position
	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			mob.global_position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	
	# The mob reached the end of the path.
	mob.global_position = last_point
	set_process(false)

func _update_navigation_path(start_position, end_position):
	path = nav.get_simple_path(start_position, end_position, true)
	path.remove(0)
#	set_process(true)

func get_total_path_distance():
	if path.size() > 0:
		var distance = 0.0
		
		distance += path[0].distance_to(mob.global_position)
		
		for index in range(path.size() - 1):
			if index != 0:
				distance += path[index].distance_to(path[index-1])
	
		return distance
	else:
		pass


	

## SIGNALS


## SETGET


## EXECUTION
func _ready():
#	_update_navigation_path(mob.position, destination.position)
#	_update_navigation_path(mob.global_position, destination.global_position) # test for fixing instancing issues of parent node
	_update_navigation_path(start.global_position, destination.global_position) # test for fixing instancing issues of parent node

func _physics_process(delta):
	if mob != null:
		move_along_path(mob.speed)

#func _unhandled_input(event):
#	if event.is_action_pressed("click"):
#		_update_navigation_path(mob.position, get_global_mouse_position())
#		print("Total path distance: ", get_total_path_distance())
#	pass