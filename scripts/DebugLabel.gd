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
#onready var mobs = get_tree().get_nodes_in_group("mobs")
#onready var tilemap = $"/root/main/tilemap_buildings" as TileMap
onready var zone_path = $"/root/main/zone_path" as TileMap
onready var Util = $"/root/main/Util"

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
	
func add_debug_message(message: String):
	debug_message += "\n" + message

func update_debug_message():
	# Clear the debug message
	debug_message = ""
	
	## Cell at cursor
	var cell_name: String
	
	selected = Util.selected_cell
	
	if selected:
		match selected.id:
			-1: cell_name = "Empty"
			0: cell_name = "Grass"
			1: cell_name = "fence"
			2: cell_name = "dirt"
			3: cell_name = "platform_base" # "tower"
			4: cell_name = "chicken-placeholder"
	
		debug_message += \
		"""
		Cell: %s
		Cell_id: %s
		Cell_name: %s
		""" % [selected.coordinates, selected.id, cell_name]
	
	## Grabbed chicken
	add_debug_message("\nGrabbed chicken: %s" % [Util.grabbed_chicken])
	
	## Mobs
	add_debug_message("\nTotal mobs: %s" % [get_tree().get_nodes_in_group("mobs").size()])
	
	# Chickens
	for chicken in chickens:
		debug_message += \
			"""
			Chicken : %s
			Cell : %s
			""" % [chicken, chicken.current_cell]
	
	
	
#	for mob in mobs:
#		if mob != null:
#			debug_message += \
#				"""
#				Mob: %s
#				Mob distance to destination: %s
#				""" % [mob, mob.distance]
	
	
## SETGET


## EXECUTION
func _ready():
#	ready_fonts()
	self.add_to_group("debug_label")

func _process(_delta):
	update_debug_message()
	process_debug_label()
	
