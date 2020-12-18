extends TextureButton
#extends CheckButton

## VARS
export(String) var label_text

onready var label = $menu_button_label as Label
onready var last_position = label.rect_position as Vector2

## FUNCS


## SIGNALS
#func _on_button_down():
#
#
#func _on_button_up():
func _on_button_down():
	if pressed:
		label.rect_position += Vector2(1,1)

func _on_button_up():
	if not pressed:
		label.rect_position = last_position

func _on_button_toggled(button_pressed):
	if button_pressed:
		label.rect_position += Vector2(1,1)
	else:
		label.rect_position = last_position


## SETGET


## EXECUTION
func _ready():
	self.toggle_mode = true
#	label.text = label_text
	
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	connect("toggled", self, "_on_button_toggled")

