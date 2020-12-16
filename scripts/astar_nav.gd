extends AStarPath

## VARS
onready var start_position = tilemap_ground.world_to_map($"/root/main/start_position".global_position)
onready var end_position = tilemap_ground.world_to_map($"/root/main/end_position".global_position)

## FUNCS

## SIGNALS


## SETGET


## EXECUTION

func _ready():
	_calculate_path(start_position, end_position)  

