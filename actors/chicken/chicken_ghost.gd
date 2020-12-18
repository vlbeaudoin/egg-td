extends Node2D

var origin_chicken: Node setget set_origin_chicken
var origin: Vector2

var trail: Line2D

onready var main = $"/root/main"
onready var mob_spawn = $"/root/main/mob_spawn"

func set_origin_chicken(chicken: Node):
	#TODO draw a line from the chicken's ghost to the chicken
#	Line2D
	origin_chicken = chicken
	

func draw_trail():
	origin = origin_chicken.global_position
	trail = Line2D.new()
	trail.z_index = 1
	trail.width = 5
	main.add_child_below_node(mob_spawn, trail)

#func _ready():
#	set_process(true)

func _process(_delta):
	self.global_position = get_viewport().get_mouse_position()
	
	if trail and origin and origin_chicken:
		trail.points = PoolVector2Array([origin, self.global_position])
		
	
	
#	update()

#func _draw():
#	main.draw_line(origin, self.global_position, Color.aliceblue, 3)
