extends KinematicBody2D

## VARS
onready var chicken_fsm = $chicken_fsm
onready var chicken_aim = $chicken_aim


var power = 1
var attack_speed = 1
var projectile_speed = 1

var chase = true

var adjectives = []

## FUNCS
func aim_at(target):
	chicken_aim.look_at(target)

## SIGNALS


## SETGET
func get_state():
	return chicken_fsm.get_state()

## EXECUTION
func _ready():
	add_to_group("chicken")

func _process(delta):
	aim_at(get_viewport().get_mouse_position())
