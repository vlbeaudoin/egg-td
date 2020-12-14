class_name WaveClump
extends Resource


## VARS
export(String) var spawn_mob setget set_spawn_mob
export(int) var spawn_amount setget set_spawn_amount
export(int) var spawn_speed setget set_spawn_speed

## FUNCS


## SIGNALS


## SETGET
func set_spawn_mob(new_spawn_mob: String):
	spawn_mob = new_spawn_mob
	
func set_spawn_amount(new_spawn_amount: int):
	spawn_amount = new_spawn_amount

func set_spawn_speed(new_spawn_speed: float):
	spawn_speed = new_spawn_speed

## EXECUTION
func _init(new_spawn_mob: String = "res://actors/mob/mob.tscn", new_spawn_amount: int = 1, new_spawn_speed: float = 1.5):
	spawn_mob = new_spawn_mob
	spawn_amount = new_spawn_amount
	spawn_speed = new_spawn_speed
