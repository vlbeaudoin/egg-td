extends Popup

## VARS
onready var resume = $menu_button as TextureButton

## FUNCS
func switch_pause():
	if get_tree().paused:
		self.hide()
	else:	
		self.popup_centered()
#		last_position = resume_label.rect_position as Vector2
		
	get_tree().paused = not get_tree().paused
	print()

## SIGNALS
func _on_resume_pressed():
	switch_pause()
	



## SETGET


## EXECUTION
func _ready():
	resume.connect("pressed", self, "_on_resume_pressed")

#	connect("pressed", self, "_on_resume_pressed")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		switch_pause()
	
