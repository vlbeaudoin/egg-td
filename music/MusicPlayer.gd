extends Node

export(float, 0,1) var dynamic := 1.0 setget set_dynamic

func set_dynamic(v:float):
	dynamic = clamp(v, 0, 1)
	

onready var audio = {
	soft = $soft,
	loud = $loud
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	play_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_music(time:float=0):
	audio.soft.play(time)
	audio.loud.play(time)
