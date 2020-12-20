extends HSlider



func _on_volumeSlider_value_changed(value):
	MusicPlayer.set_music_volume(value)
