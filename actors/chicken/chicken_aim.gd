extends Area2D

## VARS


## FUNCS
func aim_at(target):
	if target != null:
		look_at(target.global_position)



## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass

func _process(delta):
#	obtain_target()
	aim_at(get_parent().get_target())
