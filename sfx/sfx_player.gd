extends Node

onready var _sfx = {
	warning = $warning
}

func play_sfx(name, time:=0.0):
	_sfx[name].play(time)


func sfx_splat(pos:Vector2):
	$splat.play(pos)
