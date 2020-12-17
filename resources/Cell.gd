class_name Cell
extends Resource


## VARS
export(int) var id
export(Vector2) var coordinates


## FUNCS


## SIGNALS


## SETGET


## EXECUTION
func _init(new_id: int, new_coordinates: Vector2):
	self.id = new_id
	self.coordinates = new_coordinates

func _ready():
	pass
