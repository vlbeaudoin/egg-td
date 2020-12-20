extends KinematicBody2D
#extends Area2D

## VARS
onready var chicken_fsm = $chicken_fsm
onready var chicken_aim = $chicken_aim
onready var chicken_reach = $chicken_reach
onready var chicken_trail = $chicken_trail
onready var util = $"/root/main/util"

#onready var mob

var target
onready var detected = chicken_reach.detected

var luck = 1 #TODO Implement luck for more chance at rare drops (helmets and egg production)
var power = 1 # The damage this chicken does on hit
var attack_speed = 1 # Lower attack speed = more shots per second
var projectile_speed = 250
#var move_speed = 10

#var from_cell: Cell
var current_cell: Cell

onready var projectile = load("res://projectiles/projectile_egg.tscn")
onready var player_buildings = $"/root/main/player_buildings" as TileMap

var eggs_timer := Timer.new()
var eggs_timer_wait_time := 3.5

#var helmet_modifiers = []

## FUNCS
func release():
	chicken_trail.handle_grabbed_chicken_dropped()

func _initialize_current_cell():
	var initial_cell_coords = player_buildings.world_to_map(self.position)
	var initial_cell_id = player_buildings.get_cellv(initial_cell_coords)
	
	current_cell = Cell.new(initial_cell_id, initial_cell_coords)

func move_from_to(from: Cell, to: Cell):
#	from_cell = from
	current_cell = to
	
	global_position = player_buildings.map_to_world(current_cell.coordinates)
	global_position.x += 8
	SFXPlayer.sfx_bruh(global_position)

#func produce_eggs():
#	if eggs_timer.is_stopped():
#		eggs_timer.start()

func handle_production_defense():
	if util.game_mode == util.GameModes.WAVE:
		match current_cell.id:
			util.Cells.FENCE:
				if target:
					chicken_aim.aim_at(target)
				eggs_timer.stop()
			util.Cells.NESTBOX:
				if eggs_timer.is_stopped():
					eggs_timer.start()

## SIGNALS
func _on_eggs_timer_timeout():
	if util.game_mode == util.GameModes.BUILD:
		eggs_timer.stop()
		return
	else:
		var roll = randi() % (100 + luck)
	
	
		if roll >= 80: # 80 or higher gets twice the eggs (crit) (1/5)
	#		var special_egg = randi() % 
			print_debug("Crit! {%s} dropped twice the eggs." % [self])
			util.inv.white_eggs += power * 2
		else:
			
			print_debug("{%s} dropped an egg." % [self])
			util.inv.white_eggs += power
		

## SETGET
func get_state():
	return chicken_fsm.get_state()

#func get_target():
#	if chicken_reach:
#		return target

func get_detected():
	return chicken_reach.get_detected()

func set_mob_priority(new_mob_priority):
	chicken_reach.select_mob_priority(new_mob_priority)
	
func get_mob_priority():
	return chicken_reach.get_mob_priority()

func set_current_cell(value: Cell):
	current_cell = value

## EXECUTION
func _ready():
	add_to_group("chickens")
	_initialize_current_cell()
	eggs_timer.connect("timeout", self, "_on_eggs_timer_timeout")
	eggs_timer.wait_time = eggs_timer_wait_time / attack_speed
	add_child(eggs_timer)
	randomize()

func _process(_delta):
	handle_production_defense()
