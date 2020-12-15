extends KinematicBody2D

## VARS
const DEBUG = false
var damage = 1
var target

var time_to_live = 3 # Maximum amount of seconds the projectile can stay on screen
var time_to_live_timer = Timer.new()

var velocity: Vector2

onready var tilemap = get_node("/root/main/tilemap_buildings")
onready var visibility_notifier = $VisibilityNotifier2D
onready var area2d = $Area2D


## FUNCS
func fire(aim_rotation: float, projectile_speed: int):
	look_at(target.global_position)
	velocity = Vector2(projectile_speed,0).rotated(aim_rotation)

## SIGNALS
func _on_body_entered(body):
	if "mob_type" in body:
		if DEBUG:
			print("[dbg] {%s} collided with {%s}" % [body, self])
		body.hurt(damage)
		queue_free()

func _on_tilemap_exited(): 
	#TODO call this when the instance exits the \
	#tilemap_buildings.map_size area
	queue_free()

## SETGET


## EXECUTION
func _ready():
	area2d.connect("body_entered", self, "_on_body_entered")
	visibility_notifier.connect("screen_exited", self, "_on_tilemap_exited")
	
	add_child(time_to_live_timer)
	
	time_to_live_timer.connect("timeout", self, "_on_tilemap_exited")
	time_to_live_timer.wait_time = time_to_live
	time_to_live_timer.start()

func _physics_process(_delta):
#	if not position == null:
	move_and_slide(velocity)
	#TODO change move_and_slide for a linear interpolate
