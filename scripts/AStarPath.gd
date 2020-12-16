class_name AStarPath
extends Node2D
#extends TileMap

## VARS
onready var tilemap_buildings = $"/root/main/tilemap_buildings"
onready var tilemap_ground = $"/root/main/tilemap_ground"

onready var astar = AStar2D.new()

var path: PoolVector2Array



var obstacles_array: Array # TODO update this when someone places a building, before calculating _get_path
var ground_array: Array # Contains the ground below the playing field for towers, plus padding on both sides for the start and destination of the path.
var walkable_cells_array: Array # Contains all the cells which are available for pathfinding. Obtained by comparing tilemap_ground and tilemap_buildings.

## FUNCS
func update_cells_arrays():
	ground_array = tilemap_ground.get_used_cells()
	obstacles_array = tilemap_buildings.get_used_cells()
	
	for tile in ground_array:
			if not tile in obstacles_array :
				walkable_cells_array.append(tile)

func _add_points():
	for cell in walkable_cells_array:
		astar.add_point(id(cell), cell)

func _connect_points():
	for cell in walkable_cells_array:
			var neighbors = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
			
			for neighbor in neighbors:
				var next_cell = cell + neighbor
				if walkable_cells_array.has(next_cell):
					astar.connect_points(id(cell), id(next_cell))

func _calculate_path(start, end):
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
