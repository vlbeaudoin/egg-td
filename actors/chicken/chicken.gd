#extends KinematicBody2D
extends Area2D

## VARS
onready var chicken_fsm = $chicken_fsm
onready var chicken_aim = $chicken_aim
onready var chicken_reach = $chicken_reach
onready var chicken_trail = $chicken_trail

onready var mob

var target setget , get_target

#var luck #TODO Implement luck for more chance at rare drops (helmets and egg production)
var power = 1 # The damage this chicken does on hit
var attack_speed = 1 # Lower attack speed = more shots per second
var projectile_speed = 250

var machine_operated #TODO switch this to "nestbox" if in a nestbox, "tower" if in a tower

var projectile = load("res://items/projectile_egg.tscn")

#var chase = false # TODO make this be a thing for certain towers

var adjectives = []

## FUNCS
func release():
	chicken_trail.handle_grabbed_chicken_dropped()

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
