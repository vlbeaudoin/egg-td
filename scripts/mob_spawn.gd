extends Node2D

## VARS
const DEBUG = true

var spawn_timer = Timer.new()
var current_mob
var current_wave_clump: WaveClump

export(Array) var waves

#onready var wave = Wave.new()

onready var main = $"/root/main"
onready var zone_path = $"/root/main/zone_path" as TileMap
onready var util = $"/root/main/util"

onready var mob_boar = "res://actors/mob/mob_boar.tscn"
onready var mob_fox = "res://actors/mob/mob_fox.tscn"
onready var mob_wolf = "res://actors/mob/mob_wolf.tscn"
onready var mob_deer = "res://actors/mob/mob_deer.tscn"
onready var mob_bear = "res://actors/mob/mob_bear.tscn"

signal wave_ended

## FUNCS
func start_wave():
	if current_wave_clump and not waves.empty():
		if waves[0].wave_clumps.empty():
			return
		
		if spawn_timer.is_stopped():
			spawn_timer.start(current_wave_clump.spawn_speed)
#			spawn_timer.start()
			util.enter_state(util.GameModes.WAVE)
	else:
		return
	

func spawn_mob():
	if not waves[0].wave_clumps.empty() and not waves.empty():
		current_wave_clump = waves[0].wave_clumps[0]
		spawn_timer.wait_time = current_wave_clump.spawn_speed

		current_mob = load(current_wave_clump.spawn_mob)
		
		if current_wave_clump and current_mob:
			var new_mob = current_mob.instance()
			main.add_child_below_node(self, new_mob)
			new_mob.position = self.position - Vector2(zone_path.cell_size.x / 2, zone_path.cell_size.y / 2)
			current_wave_clump.spawn_amount -= 1
		
		if current_wave_clump.spawn_amount == 0: 
			# There are no more mobs in waves[0].wave_clumps[0]
			waves[0].wave_clumps.pop_front()
			
			if waves[0].wave_clumps.empty():
				# There are no more wave_clumps in waves[0].wave_clumps
				waves.pop_front()
				spawn_timer.stop()
				emit_signal("wave_ended")
			else: # There are still clumps left
				current_wave_clump = waves[0].wave_clumps[0]
				spawn_timer.wait_time = current_wave_clump.spawn_speed
		
		if waves.empty():
			# There are no more waves in waves
			# The game is over
			if DEBUG:
				print("No more waves!")

func add_wave_clump(p_wave: Wave, spawn_mob: String, spawn_amount:int = 5, \
spawn_speed: float = 1.5):
	var wave_clump = WaveClump.new()
	
	wave_clump.spawn_amount = spawn_amount
	wave_clump.spawn_speed = spawn_speed
	wave_clump.spawn_mob = spawn_mob
	
	p_wave.add_clump(wave_clump)
#	waves.append(p_wave)
	
	if not current_wave_clump:
#		current_wave_clump = waves[0].wave_clumps[0]
		current_wave_clump = p_wave.wave_clumps[0]
	

#func add_wave(p_wave: Wave):
##	var new_wave = Wave.new()
#
#		waves.append(p_wave)
	
	

func initialize_waves():
	
	for wave_index in range(15):
		var wave = Wave.new()
		
		match wave_index+ 1:
			1: add_wave_clump(wave, mob_boar, 1, 1)
			2: add_wave_clump(wave, mob_fox, 5, 1)
			3: add_wave_clump(wave, mob_wolf, 3, 1)
			4: add_wave_clump(wave, mob_deer, 2, 1.5)
			5: add_wave_clump(wave, mob_bear, 1, 2)
			6:
				add_wave_clump(wave, mob_boar, 1, 1)
				add_wave_clump(wave, mob_fox, 3, 0.8)
				add_wave_clump(wave, mob_boar, 3, 0.8)
			7: add_wave_clump(wave, mob_fox, 12, 1)
			8:
				add_wave_clump(wave, mob_deer, 1, 1)
				add_wave_clump(wave, mob_fox, 1, 1)
				add_wave_clump(wave, mob_bear, 1, 1)
				add_wave_clump(wave, mob_wolf, 1, 1)
				add_wave_clump(wave, mob_boar, 1, 1)
			9:
				add_wave_clump(wave, mob_fox, 5, 0.8)
				add_wave_clump(wave, mob_wolf, 10, 0.8)
			10: 
				add_wave_clump(wave, mob_bear, 8, 1.8)
			11:
				add_wave_clump(wave, mob_deer, 9, 1.2)
			12:
				add_wave_clump(wave, mob_wolf, 25, 0.7)
				add_wave_clump(wave, mob_bear, 25, 1.2)
			13:
				add_wave_clump(wave, mob_fox, 40, 0.6)
			14:
				add_wave_clump(wave, mob_boar, 37, 0.6)
			15:
				add_wave_clump(wave, mob_deer, 12, 1)
				add_wave_clump(wave, mob_bear, 12, 1)
			_:
				return
		
		waves.append(wave as Wave)
	
	#TODO prepare multiple waves in advance (json?)
	# [dbg] Press "spacebar" to add a test wave clump to waves
#	if Input.is_action_just_pressed("ui_accept"):
##		add_wave_clump(wave) # Modify this method to send something different
##		add_wave_clump(wave, 25, 0.8, "res://actors/mob/mob_boar.tscn") # 25 boars, 0.8 timer
#		add_wave_clump(wave, 1, 0.5, "res://actors/mob/mob_wolf.tscn") # 1 wolf
#
#	if Input.is_action_just_pressed("ui_down"):
#		add_wave_clump(wave, 10, 1, "res://actors/mob/mob_fox.tscn") # 10 foxes
#
#	if Input.is_action_just_pressed("ui_up"):
#		add_wave_clump(wave, 3, 2, "res://actors/mob/mob_bear.tscn") # 3 bears
	
	

## SIGNALS
func _on_spawn_timer_timeout():	
	spawn_mob()

## SETGET


## EXECUTION
func _ready():
	# Spawn Timer
	add_child(spawn_timer)
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	
	initialize_waves()

#func _physics_process(_delta):
#	pass
	
