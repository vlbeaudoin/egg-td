extends Label

const DEBUG = true

var debug_menu = false
var debug_message_base = "F3 - Debug menu"
var debug_message = ""

var items
var selected
var msg_selected

var dynamic_font = DynamicFont.new()
var dynamic_font_size = 6

onready var chickens = get_tree().get_nodes_in_group("chicken")
onready var mobs = get_tree().get_nodes_in_group("mobs")

func ready_fonts():
#	dynamic_font.font_data = load("res://fonts/Retro Gaming.ttf")
	dynamic_font.font_data = load("res://fonts/open-sans.regular.ttf")
	dynamic_font.size = dynamic_font_size
	self.set("custom_fonts/font", dynamic_font)

func process_debug_label():
	if DEBUG:
		if Input.is_action_just_pressed("debug"):
			debug_menu = !debug_menu
			
		visible = debug_menu
		
		set_text(debug_message_base + "\n" + debug_message)
	

func update_debug_message():
	debug_message = ""

	for chicken in chickens:
		debug_message += \
			"""
			Chicken : %s
			State   : %s
			Target  : %s
			Detected: %s
			""" % [chicken, chicken.get_state(), chicken.get_target(), \
				chicken.get_detected()]
	
	for mob in mobs:
		debug_message += \
			"""
			Mob: %s
			Mob distance to destination: %s
			""" % [mob, mob.get_]
	
	
## SETGET


## EXECUTION
func _ready():
#	ready_fonts()
	self.add_to_group("debug_label")

func _process(_delta):
	update_debug_message()
	process_debug_label()
	
