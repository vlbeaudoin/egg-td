extends Area2D
# This node serves as the chicken's weapon system, for nodes that are within reach of chicken_reach

## VARS
const DEBUG = false
var fire_timer = Timer.new()


# References
onready var main = get_node("/root/main")
onready var chicken = get_parent()

## FUNCS
func aim_at(target):
	if target != null:
		look_at(target.global_position)
		
		if fire_timer.is_stopped():
			fire_timer.start(chicken.attack_speed)
			
	elif not fire_timer.is_stopped(): # stops the timer if there is no more target
		fire_timer.stop()

func fire_at(target):
	if target == null:
		return
	
	var projectile_type = chicken.projectile
	var projectile = projectile_type.instance()
	
	get_parent().add_child(projectile)
	
	projectile.global_position = chicken.global_position
	projectile.target = chicken.target
	projectile.fire(get_rotation() as float, chicken.projectile_speed)
	
	
	if DEBUG:
		print("{%s} is shooting {%s}" % [chicken, target])
	

## SIGNALS
func _on_fire_timer_timeout():
	#TODO if chicken.get_target is inside tilemap_buildings boundaries:
	fire_at(chicken.get_target())

## SETGET


## EXECUTION
func _ready():
	add_child(fire_timer)
	fire_timer.connect("timeout", self, "_on_fire_timer_timeout")

func _process(_delta):
	#TODO if chicken.get_target is inside tilemap_buildings boundaries:
	aim_at(chicken.get_target())
