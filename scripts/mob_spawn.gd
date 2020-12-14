extends Node2D

## VARS
const DEBUG = false

var spawn_timer = Timer.new()

export var disabled = false

var current_mob

onready var nav2d = get_tree().get_nodes_in_group("nav2d")

export(Array) var waves
var current_wave_clump: WaveClump

## FUNCS
func start_wave():
	current_wave_clump = waves[0].wave_clumps[0]
	current_mob = load(current_wave_clump.spawn_mob)
	spawn_timer.start(current_wave_clump.spawn_speed)


func spawn_mob():
	current_wave_clump = waves[0].wave_clumps[0]
	
	if current_wave_clump and current_mob:
		var new_mob = current_mob.instance()
		get_parent().add_child_below_node(self, new_mob)
		new_mob.position = self.position
		
		current_wave_clump.spawn_amount -= 1
	
	if current_wave_clump.spawn_amount == 0: 
		# There are no more mobs in waves[0].wave_clumps[0]
		waves[0].wave_clumps.pop_front()
	
	if waves[0].wave_clumps.size() == 0:
		# There are no more wave_clumps in waves[0].wave_clumps
		waves.pop_front()
	
	if waves.size() == 0:
		# There are no more waves in waves
		spawn_timer.stop()
		#TODO announce the stop of the wave (signal)
	
func prepare_test_wave():
	var new_wave = Wave.new()
	var new_wave_clump = WaveClump.new()
	
	new_wave_clump.spawn_amount = 5
	new_wave_clump.spawn_speed = 1
	
	new_wave.add_clump(new_wave_clump)
	waves.append(new_wave)

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
	
	# Start the wave
	# start_wave()

func _physics_process(_delta):	
	# [dbg] Press "spacebar" to add a test wave clump to waves
	if Input.is_action_just_pressed("ui_accept"):
		prepare_test_wave()
		
		if current_wave_clump and not disabled:
			start_wave()
