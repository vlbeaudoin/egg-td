class_name AStarPath
extends Node2D
#extends TileMap

## VARS
onready var reference_tilemap = $"/root/main/tilemap_buildings"
#onready var obstacles_tilemap = $"/root/main/tilemap_buildings"
#onready var reference_tilemap = $"/root/main/tilemap_ground"

onready var astar = AStar2D.new()
#onready var used_cells = reference_tilemap.get_used_cells()

export var tilemap_size := Vector2(13, 11)
export var tilemap_top_left := Vector2(12,4)
#var tilemap_rect = Rect2(24, 14, 13, 11)

var path: PoolVector2Array

var walkable_cells_array: Array

export var obstacles_array: Array # TODO update this when someone places a building, before calculating _get_path

## FUNCS
func update_cells_arrays():
	obstacles_array = reference_tilemap.get_used_cells()
#	obstacles_array = obstacles_tilemap.get_used_cells()
	
#	for y_index in range(tilemap_size.y):
	for y_index in range(tilemap_top_left.y, tilemap_size.y + tilemap_top_left.y):
#		print("y_index: ", y_index)
		for x_index in range(tilemap_top_left.x, tilemap_size.x + tilemap_top_left.x):
#			print("x_index: ", x_index)
			
			if not Vector2(x_index, y_index) in obstacles_array :
#				print("(%s, %s)" % [x_index, y_index])
#			if not obstacles_array.has(Vector2(x_index, y_index)):
#			if not obstacles_array[obstacles_array.find(Vector2(x_index, y_index))]:
#			if not obstacles_tilemap.get_cell(x_index, y_index): #TODO not fixed but close
#				walkable_cells_array.append(Vector2(x_index + tilemap_top_left.x, y_index + tilemap_top_left.y))
				
#				walkable_cells_array.append(Vector2())
				
				walkable_cells_array.append(Vector2(x_index, y_index))
#				print("yay")
		
#	print(walkable_cells_array) #TODO not fixed but close

func _add_points():
#	print("foo")
	
	for cell in walkable_cells_array:
#		astar.add_point(id(x_index + tilemap_top_left.x), id(y_index + tilemap_top_left.y))
		astar.add_point(id(cell), cell)
#		astar.add_point(id(cell.x), cell.y)


#	for cell in used_cells:
#		if not obstacles_tilemap.get_cell(cell.x, cell.y):
#			astar.add_point(id(cell), cell)

func _connect_points():
#	for cell in used_cells:
	for cell in walkable_cells_array:
#		if not obstacles_tilemap.get_cell(cell.x, cell.y):
			# Check neighbors
			var neighbors = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
			
			for neighbor in neighbors:
				var next_cell = cell + neighbor
				if walkable_cells_array.has(next_cell):
					astar.connect_points(id(cell), id(next_cell))

func _get_path(start, end): #TODO make this work
#	if path:
#		path = astar.get_point_path(id(start), id(end))
#		print(path)
#	else:
#		print("[dbg] There is no path from %s to %s" % [start, end])
#	path.remove(0)
	path = astar.get_point_path(id(start), id(end))
	path.remove(0)

func id(point):
	var a = point.x
	var b = point.y
	
	return (a + b) * ( a + b + 1) / 2 + b

## SIGNALS

## SETGET

## EXECUTION
func _ready():
	update_cells_arrays()
	_add_points()
	_connect_points()
