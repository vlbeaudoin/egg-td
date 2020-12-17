extends Node2D

## VARS
const DEBUG = false

var spawn_timer = Timer.new()

export var disabled = false

var current_mob


export(Array) var waves #TODO make this a WaveArray instead (also implement it lol)

onready var wave = Wave.new() #TODO have a way to have more than 1 wave (or prepare a few more waves, a WaveArray would be a good way to allow making waves in the inspector

var current_wave_clump: WaveClump

onready var main = $"/root/main"
#onready var player_buildings = $"/root/main/player_buildings"
onready var zone_path = $"/root/main/zone_path" as TileMap

## FUNCS
func start_wave():
	if waves[0].wave_clumps.empty():
		return
	current_wave_clump = waves[0].wave_clumps[0]
	current_mob = load(current_wave_clump.spawn_mob)
	
	if spawn_timer.is_stopped():
		spawn_timer.start(current_wave_clump.spawn_speed)
#		spawn_timer.start()


func spawn_mob():
	current_wave_clump = waves[0].wave_clumps[0]
	spawn_timer.wait_time = current_wave_clump.spawn_speed
	
	if current_wave_clump and current_mob:
		spawn_timer.wait_time = current_wave_clump.spawn_speed
		var new_mob = current_mob.instance()
#		get_parent().add_child_below_node(self, new_mob)
		main.add_child_below_node(self, new_mob)
#		new_mob.position = self.position
		new_mob.position = self.position - Vector2(zone_path.cell_size.x / 2, zone_path.cell_size.y / 2)
		
		current_wave_clump.spawn_amount -= 1
	
	if current_wave_clump.spawn_amount == 0: 
		# There are no more mobs in waves[0].wave_clumps[0]
		waves[0].wave_clumps.pop_front()
		spawn_timer.stop()
	
	if waves[0].wave_clumps.size() == 0:
		# There are no more wave_clumps in waves[0].wave_clumps
		waves.pop_front()
	
	if waves.size() == 0:
		# There are no more waves in waves
#		spawn_timer.stop() # not necessary as there is already a check when the wave clump is done.
		#TODO announce the stop of the wave (signal)
		pass


func add_wave_clump(p_wave: Wave = wave, spawn_amount:int = 5, spawn_speed: float = 1.5):
#	var new_wave = Wave.new() #TODO probably shouldn't instantiate a whole new wave every clump
	var wave_clump = WaveClump.new()
	
	wave_clump.spawn_amount = spawn_amount
	wave_clump.spawn_speed = spawn_speed
	
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
	# [dbg] Press "spacebar" to add a test wave clump to waves
	if Input.is_action_just_pressed("ui_accept"):
		add_wave_clump(wave) # Modify this method to send something different
	
	if Input.is_action_just_pressed("ui_down"):
		add_wave_clump(wave, 10, 0.5)
	
	if Input.is_action_just_pressed("ui_up"):
		add_wave_clump(wave, 1, 0.1)
	
	
	if current_wave_clump and not disabled and not waves.empty():
		start_wave()
