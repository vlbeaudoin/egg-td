extends Node2D

## VARS
var selected
var grabbed_chicken

## FUNCS
func process_input():
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://scenes/main.tscn")
		
	if Input.is_action_just_released("click"):
		#TODO 
		if grabbed_chicken:
			grabbed_chicken.release()
			
## SIGNALS


## SETGET


## EXECUTION
func _ready():
	pass

func _process(_delta):
	process_input()
