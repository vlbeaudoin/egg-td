extends Popup

## VARS
onready var resume = $"resume"

## FUNCS
func switch_pause():
	if get_tree().paused:
		self.hide()
	else:	
		self.popup_centered()
		
	get_tree().paused = not get_tree().paused

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
	
