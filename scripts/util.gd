extends Node2D

## VARS


## FUNCS
func process_input():
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://scenes/main.tscn")

## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass

func _process(delta):
	process_input()
