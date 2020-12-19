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

onready var chickens = get_tree().get_nodes_in_group("chickens")
#onready var mobs = get_tree().get_nodes_in_group("mobs")
#onready var tilemap = $"/root/main/tilemap_buildings" as TileMap
onready var zone_path = $"/root/main/zone_path" as TileMap
onready var util = $"/root/main/util"

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
	
	selected = util.selected_cell
	
	if selected:
		match selected.id:
			util.Cells.EMPTY: cell_name = "Empty"
			util.Cells.GRASS: cell_name = "Grass"
			util.Cells.FENCE: cell_name = "Fence"
			util.Cells.DIRT: cell_name = "Dirt"
			util.Cells.NESTBOX: cell_name = "Platform base (nestbox)" # "tower"
			4: cell_name = "chicken-placeholder"
	
		add_debug_message( \
		"""Cell: %s
		Cell_id: %s
		Cell_name: %s
		""" % [selected.coordinates, selected.id, cell_name])
	
	## Gamemode
	var mode: String
	match util.game_mode:
		0: mode = "Build"
		1: mode = "Wave"
	
	add_debug_message("Game mode: %s" % mode)

	## Grabbed chicken
	add_debug_message("Grabbed chicken: %s" % [util.grabbed_chicken])

	## Mobs
	add_debug_message("Total mobs: %s" % [util.total_mobs])
	
	## Selected building
	add_debug_message("Selected building: %s" % [util.selected_building])
	
	## Resources
	add_debug_message("White eggs: %s" % [util.inv_white_eggs])
	

	
	# Chickens
	
	for chicken in chickens:
		if chicken:
			add_debug_message(\
			"""Chicken: %s | target: %s | detected: %s | Cell: %s, %s
			""" % [chicken, chicken.target, chicken.detected, chicken.current_cell.id, chicken.current_cell.coordinates])
	
	
	
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
	
