extends Node

export var loud_xf_curve:Curve
export var soft_xf_curve:Curve
export(float, 0,1) var dynamic := 1.0 setget set_dynamic
export var loop_point = 15.6


# please use a tween or smoothly lerp this value, do not set or call directly
# as it will result in clicks and artifacts
func set_dynamic(v:float):
	dynamic = clamp(v, 0, 1)
	set_music_dynamics(dynamic)

onready var audio = {
	soft = $soft,
	loud = $loud
}

const buses = {
	music = 1, #AudioServer.get_bus_index("Music")
	soft = 3, #AudioServer.get_bus_index("m_layer_soft"),
	loud = 4  #AudioServer.get_bus_index("m_layer_loud")
}


func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	play_music()
	
#	$Tween.start()

func set_music_dynamics(dyn:float):
	var soft_volume_db = linear2db(soft_xf_curve.interpolate(dyn))
	var loud_volume_db = linear2db(loud_xf_curve.interpolate(dyn))
	AudioServer.set_bus_volume_db(buses.soft, soft_volume_db)
	AudioServer.set_bus_volume_db(buses.loud, loud_volume_db)
	

func play_music(time:float=0):
	var tminus:float
	tminus = clamp(AudioServer.get_time_to_next_mix(),0,1)
	audio.soft.play(time+tminus)
#	print(tminus)
	tminus = clamp(AudioServer.get_time_to_next_mix(),0,1)
	audio.loud.play(time+tminus)
#	print(tminus)


func fade_music(target_dyn:float, time:float=6):
	var t = $Tween
	t.stop_all()
	t.interpolate_method(
		self, "set_dynamic", dynamic, 
		target_dyn, time, 
		Tween.TRANS_LINEAR)
	t.start()

func set_music_volume(vol:float):
	AudioServer.set_bus_volume_db(buses.music, linear2db(vol))


func _on_soft_finished():
	play_music(loop_point)

