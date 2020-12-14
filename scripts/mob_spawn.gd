extends Node2D

## VARS
var spawn_timer = Timer.new()

export var spawn_speed: int = 1
export var mob_res = preload("res://actors/mob/mob.tscn")
export var disabled = false

#onready var mobs_navigation = get_parent()


## FUNCS
func spawn_mob(mob_type = mob_res): 
	var mob = mob_type.instance()
	get_parent().add_child(mob)
	mob.global_position = self.global_position
	
	return(mob)

## SIGNALS
func _on_spawn_timer_timeout():
	spawn_mob()

## SETGET
#func set_mob_type(new_mob_type):
#	mob_type = new_mob_type

## EXECUTION
func _ready():
	add_child(spawn_timer)
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	
	spawn_timer.start(spawn_speed)

func _physics_process(_delta):
	if disabled:
		spawn_timer.stop()
