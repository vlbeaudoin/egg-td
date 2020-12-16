extends Node2D

var origin_chicken: Node
var origin: Vector2

var trail: Line2D

onready var main = $"/root/main"

func set_origin_chicken(chicken: Node):
	#TODO draw a line from the chicken's ghost to the chicken
#	Line2D
	origin_chicken = chicken
	origin = origin_chicken.global_position
	
	trail = Line2D.new()
	main.add_child(trail)

#func _ready():
#	set_process(true)

func _process(delta):
	self.global_position = get_viewport().get_mouse_position()
	
	if trail and origin and origin_chicken:
		trail.points = PoolVector2Array([origin, self.global_position])
		
	
	
#	update()

#func _draw():
#	main.draw_line(origin, self.global_position, Color.aliceblue, 3)
