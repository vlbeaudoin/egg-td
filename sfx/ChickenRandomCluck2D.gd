extends Node2D

export var interval_distribution : Curve

onready var clucks = [$cluck1, $cluck2, $cluck3, $cluck4]

func _ready():
	wait_random()

func wait_random():
	$Timer.start(interval_distribution.interpolate(randf()))


func _on_Timer_timeout():
	clucks[randi() % clucks.size()].play()
