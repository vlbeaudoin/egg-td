extends Node

onready var _sfx = {
	warning = $warning,
	whoops = $whoops
}

func play_sfx(name, time:=0.0):
	_sfx[name].play(time)


func sfx_splat(pos:Vector2):
	$splat.play(pos)

func sfx_bruh(pos:Vector2):
	var sfx = $bruh
	sfx.position = pos
	sfx.pitch_scale = 1 + (0.5-randf())*0.3
	sfx.play()
	$zap.play()

func sfx_knock(pos:Vector2):
	var sfx = $knock
	sfx.position = pos
	sfx.pitch_scale = 1 + (0.5-randf())*0.13
	sfx.play()

func sfx_dig(pos:Vector2):
	var sfx = $dig
	sfx.position = pos
	sfx.pitch_scale = 1 + (0.5-randf())*0.13
	sfx.play()
