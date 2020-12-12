extends KinematicBody2D

## VARS
onready var chicken_fsm = $chicken_fsm
onready var chicken_aim = $chicken_aim
onready var chicken_reach = $chicken_reach
#onready var mob = get_tree().get_nodes_in_group("mob")[0]
onready var mob = get_node("/root/main/mob")


var power = 1
var attack_speed = 1
var projectile_speed = 1

var chase = true

var adjectives = []

## FUNCS


## SIGNALS


## SETGET
func get_state():
	return chicken_fsm.get_state()

func get_target():
	return chicken_reach.get_target()

func get_detected():
	return chicken_reach.get_detected()

## EXECUTION
func _ready():
	add_to_group("chicken")

func _process(delta):
	pass
#	aim_at(get_viewport().get_mouse_position())
	
