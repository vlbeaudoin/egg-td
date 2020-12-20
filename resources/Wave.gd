class_name Wave
extends Resource


## VARS
export(String) var wave_name
export(Array, Resource) var wave_clumps
export(String) var description

## FUNCS
func add_clump(clump):
	wave_clumps.append(clump)

#func start_wave(wave_clumps)
#
#
#func stop_wave()


## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass
