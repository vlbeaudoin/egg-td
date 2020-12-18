extends AStarPath

## VARS
onready var start_position = zone_path.world_to_map($"/root/main/start_position".global_position) as Vector2
onready var end_position = zone_path.world_to_map($"/root/main/end_position".global_position) as Vector2

onready var main = $"/root/main" as Node2D
onready var path_shimmer = $"/root/main/path_shimmer" as Node2D
onready var shimmer_res = preload("res://particles/shimmer.tscn")

var shimmer: bool = true setget set_shimmer

## FUNCS
func set_shimmer(value: bool):
	shimmer = value

func _update_shimmer_visibility():
	if path_shimmer:
		path_shimmer.visible = shimmer

func update_path_shimmer():
	for child in path_shimmer.get_children():
		child.queue_free()
		
	for cell_position in path:
		var local_shimmer = shimmer_res.instance()
		path_shimmer.add_child(local_shimmer)
		local_shimmer.global_position = zone_path.map_to_world(cell_position) + Vector2(8,8)


## SIGNALS


## SETGET


## EXECUTION

func _ready():
	path = try_path(start_position, end_position)
	update_path_shimmer()

func _process(_delta):
	_update_shimmer_visibility()
