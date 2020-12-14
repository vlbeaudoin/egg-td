extends KinematicBody2D

## VARS
onready var chicken_fsm = $chicken_fsm
onready var chicken_aim = $chicken_aim
onready var chicken_reach = $chicken_reach
onready var mob

var target setget , get_target

var power = 1
var attack_speed = 1
var projectile_speed = 100
#var cooldown = 1.5


var projectile = load("res://items/projectile_egg.tscn")

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

func set_mob_priority(new_mob_priority):
	chicken_reach.select_mob_priority(new_mob_priority)

func get_mob_priority():
	return chicken_reach.get_mob_priority()

## EXECUTION
func _ready():
	add_to_group("chicken")	
#	while get_tree().get_nodes_in_group("mobs") == null: 
#		pass

func _process(delta):
	pass
#	aim_at(get_viewport().get_mouse_position())
	
