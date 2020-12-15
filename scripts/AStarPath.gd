class_name AStarPath
extends Node2D
#extends TileMap

## VARS
#onready var reference_tilemap = $"/root/main/tilemap_buildings"
onready var reference_tilemap = $"/root/main/tilemap_ground"

onready var astar = AStar2D.new()
onready var used_cells = reference_tilemap.get_used_cells()

var path: PoolVector2Array

## FUNCS
func _add_points():
	for cell in used_cells:
		astar.add_point(id(cell), cell)

func _connect_points():
	for cell in used_cells:
		# Check neighbors
		var neighbors = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
		
		for neighbor in neighbors:
			var next_cell = cell + neighbor
			if used_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell))

func _get_path(start, end):
	path = astar.get_point_path(id(start), id(end))
#	path.remove(0)

func id(point):
	var a = point.x
	var b = point.y
	
	return (a + b) * ( a + b + 1) / 2 + b

## SIGNALS

## SETGET

## EXECUTION
func _ready():
	_add_points()
	_connect_points()
