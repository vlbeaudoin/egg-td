extends Node2D

# round robin playback

var index = 0
onready var players = get_children()

func play(pos:Vector2):
	var p = players[index]
	p.position = pos
	p.pitch_scale = 1 + (0.5-randf())*0.3
	p.play()
	
	index += 1
	index %= players.size()
