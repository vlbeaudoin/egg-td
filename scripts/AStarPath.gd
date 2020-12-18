class_name AStarPath
extends Node2D
#extends TileMap

## VARS
const DEBUG = false

onready var player_buildings = $"/root/main/player_buildings"
onready var zone_path = $"/root/main/zone_path"
onready var zone_build = $"/root/main/zone_build"

onready var astar = AStar2D.new()


var path: PoolVector2Array
var obstacles_array: Array # TODO update this when someone places a building, before calculating _get_path
var ground_array: Array # Contains the ground below the playing field for towers, plus padding on both sides for the start and destination of the path.
var walkable_cells_array: Array # Contains all the cells which are available for pathfinding. Obtained by comparing tilemap_ground and tilemap_buildings.

## FUNCS
func _update_cells_arrays():
	ground_array = zone_path.get_used_cells()
	obstacles_array = player_buildings.get_used_cells()
	walkable_cells_array.clear()
	
	
	for tile in ground_array:
			if not tile in obstacles_array :
				walkable_cells_array.append(tile)

func _add_points():
	astar.clear()
	
	for cell in walkable_cells_array:
		astar.add_point(id(cell), cell)

func _connect_points():
	for cell in walkable_cells_array:
			var neighbors = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
			
			for neighbor in neighbors:
				var next_cell = cell + neighbor
				if walkable_cells_array.has(next_cell):
					astar.connect_points(id(cell), id(next_cell))

func try_path(start: Vector2, end: Vector2):
	var test_path = astar.get_point_path(id(start), id(end))
	
	if DEBUG:
		if test_path:
			print("[dbg] Path found between %s and %s" % [start, end])
		else:
			print("[dbg] No valid path found between %s and %s" % [start, end])
	
	return test_path

func id(point):
	var a = point.x
	var b = point.y
	
	return (a + b) * ( a + b + 1) / 2 + b

func update_astar():
	_update_cells_arrays()
	_add_points()
	_connect_points()

## SIGNALS

## SETGET

## EXECUTION
func _ready():
	update_astar()
