extends Area2D
# This node serves as the chicken's weapon system, for nodes that are within reach of chicken_reach

## VARS
const DEBUG = false
var fire_timer = Timer.new()


# References
onready var main = $"/root/main"
onready var chicken = get_parent() as KinematicBody2D
onready var sprite = chicken.get_node("ChickenIdle") as Sprite
onready var util = $"/root/main/util"

## FUNCS
func aim_at(target):
#	if target != null:
	if target:
		var target_pos = target.global_position
		look_at(target_pos)
		if target_pos.x < chicken.global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
		if fire_timer.is_stopped():
			fire_timer.start(chicken.attack_speed)
			
	elif not fire_timer.is_stopped(): # stops the timer if there is no more target
		fire_timer.stop()

func fire_at(target):
	if not target:
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
	fire_at(chicken.target)

## SETGET


## EXECUTION
func _ready():
	add_child(fire_timer)
	fire_timer.connect("timeout", self, "_on_fire_timer_timeout")

func _process(_delta):
	var cell = chicken.current_cell
	
	if cell:
		match cell.id:
			util.Cells.FENCE:
				self.visible = true
			util.Cells.NESTBOX:
				self.visible = false
	#TODO if chicken.get_target is inside tilemap_buildings boundaries:
	
