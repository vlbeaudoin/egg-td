extends TextureButton

## VARS
export(String) var label_text = "BUTTON"

onready var label = $menu_button_label as Label
onready var last_position = label.rect_position as Vector2


## FUNCS


## SIGNALS
func _on_button_down():
	label.rect_position += Vector2(1,1)

func _on_button_up():
	label.rect_position = last_position

func _on_button_pressed():
	get_tree().change_scene("res://scenes/main.tscn")

## SETGET


## EXECUTION
func _ready():
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	connect("pressed", self, "_on_button_pressed")
	
	label.text = label_text
