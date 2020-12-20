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
onready var label_wave = $"/root/main/ColorRect2/label_wave" as Label

onready var mob_boar = "res://actors/mob/mob_boar.tscn"
onready var mob_fox = "res://actors/mob/mob_fox.tscn"
onready var mob_wolf = "res://actors/mob/mob_wolf.tscn"
onready var mob_deer = "res://actors/mob/mob_deer.tscn"
onready var mob_bear = "res://actors/mob/mob_bear.tscn"
onready var mob_boss = "res://actors/mob/mob_boss.tscn"

onready var victory_popup = $"/root/main/CanvasLayer/victory_popup" as Popup

signal wave_ended
signal game_ended

## FUNCS
func start_wave():
	if current_wave_clump and not waves.empty():
		if waves[0].wave_clumps.empty():
			return
		
		if spawn_timer.is_stopped():
			spawn_timer.start(current_wave_clump.spawn_speed)
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
			emit_signal("game_ended")
			if DEBUG:
				print("No more waves!")

func add_wave_clump(p_wave: Wave, spawn_mob: String, spawn_amount:int = 5, \
spawn_speed: float = 1.5, last_wave := false):
	var wave_clump = WaveClump.new()
	
	wave_clump.spawn_amount = spawn_amount
	wave_clump.spawn_speed = spawn_speed
	wave_clump.spawn_mob = spawn_mob
	wave_clump.is_last_wave = last_wave
	
	p_wave.add_clump(wave_clump)
	
	if not current_wave_clump:
		current_wave_clump = p_wave.wave_clumps[0]
	
	

func initialize_waves():
	for wave_index in range(25):
		var wave = Wave.new()
		
		match wave_index + 1:
			1: 
				wave.description = "A wild boar is hungry for your eggs."
				add_wave_clump(wave, mob_boar, 1, 1.5)
			2: 
				wave.description = "A fox family has wandered through."
				add_wave_clump(wave, mob_fox, 10, 1.5)
			3: 
				wave.description = "Oh deer, what a majestic animal!"
				add_wave_clump(wave, mob_deer, 3, 1.5)
			4: 
				wave.description = "Wolves are coming for your eggs!"
				add_wave_clump(wave, mob_wolf, 3, 1.5)
			5: 
				wave.description = "BEAR"
				add_wave_clump(wave, mob_bear, 1, 2)
			6:
				wave.description = "The boar’s mate is angry at you, and brought friends"
				add_wave_clump(wave, mob_boar, 1, 1)
				add_wave_clump(wave, mob_fox, 3, 1.2)
				add_wave_clump(wave, mob_boar, 8, 1.2)
			7: 
				wave.description = "Do a barrel roll!"
				add_wave_clump(wave, mob_fox, 30, 1)
			8:
				wave.description = "Can’t we all just be friends?"
				add_wave_clump(wave, mob_deer, 2, 2)
				add_wave_clump(wave, mob_fox, 2, 2)
				add_wave_clump(wave, mob_bear, 2, 2)
				add_wave_clump(wave, mob_wolf, 2, 2)
				add_wave_clump(wave, mob_boar, 2, 2)
			9:
				wave.description = "A pack of wolves was chasing these foxes."
				add_wave_clump(wave, mob_fox, 8, 0.8)
				add_wave_clump(wave, mob_wolf, 5, 1)
			10: 
				wave.description = "Nekrogoblikon’s Bears"
				add_wave_clump(wave, mob_bear, 4, 2)
			11:
				wave.description = "Is it the holidays yet?"
				add_wave_clump(wave, mob_deer, 9, 0.8)
			12:
				wave.description = "Full moon. Did you know werebears are lawful-good?"
				add_wave_clump(wave, mob_wolf, 25, 0.7)
				add_wave_clump(wave, mob_bear, 5, 1.2)
			13:
				wave.description = "Foxes for days"
				add_wave_clump(wave, mob_fox, 40, 0.6)
			14:
				wave.description = "25-50 wild hogs"
				add_wave_clump(wave, mob_boar, (randi() % 25) + 26, 0.6)
			15:
				wave.description = "Tanky wave, cause why not"
				add_wave_clump(wave, mob_deer, 6, 1.2)
				add_wave_clump(wave, mob_bear, 6, 1.2)
				add_wave_clump(wave, mob_deer, 6, 1.2)
				add_wave_clump(wave, mob_bear, 6, 1.2)
				add_wave_clump(wave, mob_deer, 6, 1.2)
				add_wave_clump(wave, mob_bear, 6, 1.2)
				add_wave_clump(wave, mob_deer, 6, 1.2)
				add_wave_clump(wave, mob_bear, 6, 1.2)
			16:
				wave.description = "No more waves! The game is over! Get out of here."
				
				add_wave_clump(wave, mob_fox, 20, 0.6)
				add_wave_clump(wave, mob_boar, 20, 0.6)
			17:
				wave.description = "I mean it. There is no more content for you here."
				add_wave_clump(wave, mob_wolf, 40, 0.8)
				add_wave_clump(wave, mob_bear, 2, 1)
				add_wave_clump(wave, mob_boar, 2, 1)
				add_wave_clump(wave, mob_wolf, 40, 0.8)
			18:
				wave.description = "Although I admit it's nice to have company. This boar would probably like some company too!"
				add_wave_clump(wave, mob_boar, 1, 1)
			19:
				wave.description = "I wonder why all these animals are attracted to this place? I guess we should deal with them."
				add_wave_clump(wave, mob_deer, 15, 0.8)
				add_wave_clump(wave, mob_fox, 6, 0.7)
				add_wave_clump(wave, mob_boar, 10, 0.6)
				add_wave_clump(wave, mob_wolf, 5, 0.5)
				add_wave_clump(wave, mob_bear, 5, 0.3)
				add_wave_clump(wave, mob_boar, 18, 0.6)
			20:
				wave.description = "Oof that was more than I anticipated! I rolled pretty low on perception, so I only saw the first couple of deers."
				add_wave_clump(wave, mob_wolf, 7, 0.4)
				add_wave_clump(wave, mob_bear, 2, 0.4)	
				add_wave_clump(wave, mob_fox, 25, 0.5)
				add_wave_clump(wave, mob_bear, 2, 0.4)	
				add_wave_clump(wave, mob_deer, 15, 0.8)
			21:
				wave.description = "By the way, did you know that this coop doesn't actually exist on a physical plane per say?  There's just void around us, but the camera can't get there."
				add_wave_clump(wave, mob_deer, 20, 0.5)
				add_wave_clump(wave, mob_boar, 12, 0.5)
				add_wave_clump(wave, mob_wolf, 6, 0.7)
				add_wave_clump(wave, mob_deer, 12, 0.5)
			22:
				wave.description = "It might not make a lot of sense to you right now, but if you go to https://itch.io/jam/godot-wild-jam-28 you can get more info!"
				add_wave_clump(wave, mob_wolf, 10, 0.8)
				add_wave_clump(wave, mob_boar, 40, 0.8)
				add_wave_clump(wave, mob_bear, 10, 0.8)
				add_wave_clump(wave, mob_boar, 40, 0.8)
			23:
				wave.description = "Heh, you got through that one. Impressive. But can you get through the next one?"
				add_wave_clump(wave, mob_deer, 25, 0.6)
				add_wave_clump(wave, mob_fox, 15, 0.6)
				add_wave_clump(wave, mob_deer, 25, 0.6)
				add_wave_clump(wave, mob_bear, 7, 0.8)
			24:
				wave.description = "Those animals are quite the threat, but I guess you are as well! You've become quite fearsome, I doubt more animals are gonna come for our eggs now."
				add_wave_clump(wave, mob_fox, 50, 0.5)
				add_wave_clump(wave, mob_boar, 50, 0.5)
				add_wave_clump(wave, mob_bear, 20, 0.8)
			25:
				wave.description = "But what do I know, I'm just a chicken!"
				add_wave_clump(wave, mob_boss, 1, 1, true)
			_:
				return
		
		waves.append(wave as Wave)
		if not waves.empty():
			label_wave.text = waves[0].description

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
