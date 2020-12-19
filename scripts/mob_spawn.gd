extends Node2D

## VARS
const DEBUG = true

var spawn_timer = Timer.new()
var current_mob
var current_wave_clump: WaveClump

export(Array) var waves

onready var wave = Wave.new()

onready var main = $"/root/main"
onready var zone_path = $"/root/main/zone_path" as TileMap
onready var util = $"/root/main/util"

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

func add_wave_clump(p_wave: Wave = wave, spawn_amount:int = 5, \
spawn_speed: float = 1.5, spawn_mob: String = "res://actors/mob/mob_fox.tscn"):
	var wave_clump = WaveClump.new()
	
	wave_clump.spawn_amount = spawn_amount
	wave_clump.spawn_speed = spawn_speed
	wave_clump.spawn_mob = spawn_mob
	
	p_wave.add_clump(wave_clump)
	waves.append(p_wave)
	
	if not current_wave_clump:
		current_wave_clump = waves[0].wave_clumps[0]
	

## SIGNALS
func _on_spawn_timer_timeout():	
	spawn_mob()

## SETGET


## EXECUTION
func _ready():
	# Spawn Timer
	add_child(spawn_timer)
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")

func _physics_process(_delta):
	#TODO prepare multiple waves in advance (json?)
	# [dbg] Press "spacebar" to add a test wave clump to waves
	if Input.is_action_just_pressed("ui_accept"):
#		add_wave_clump(wave) # Modify this method to send something different
#		add_wave_clump(wave, 25, 0.8, "res://actors/mob/mob_boar.tscn") # 25 boars, 0.8 timer
		add_wave_clump(wave, 1, 0.5, "res://actors/mob/mob_wolf.tscn") # 1 wolf
	
	if Input.is_action_just_pressed("ui_down"):
		add_wave_clump(wave, 10, 1, "res://actors/mob/mob_fox.tscn") # 10 foxes
	
	if Input.is_action_just_pressed("ui_up"):
		add_wave_clump(wave, 3, 2, "res://actors/mob/mob_bear.tscn") # 3 bears
	
