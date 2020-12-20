extends Node

onready var _sfx = {
	warning = $warning
}

func play_sfx(name, time:=0.0):
	_sfx[name].play(time)
