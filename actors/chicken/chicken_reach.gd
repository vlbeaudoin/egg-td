extends Area2D

## VARS
const DEBUG = true
var msg

var target setget set_target, get_target
var detected = []

## FUNCS
func scan_area():
#	for 
#	if overlaps_body(collisionObject) in _fixed_process()
	pass

## SIGNALS
func _on_body_entered(body):
	msg = ""
	if "mob_type" in body and target == null:
		msg = "[dbg] {%s} detected collision with {%s}, a mob of type \"%s\"." % [self, body, body.get_mob_type()]
#		set_target(body)
		detected.append(body)
	
	if DEBUG and msg != null:
		print(msg)

func _on_body_exited(body):
	if body == target:
		if DEBUG:
			print("[dbg] {%s} left the range of {%s} and was the target, looking for new target" % [body, self])
		set_target(null)
	
	# Remove the leaving body from the detected array
	for mob in detected:
		if mob == body:
			detected.erase(mob)


## SETGET
func set_target(new_target):
	target = new_target

func get_target():
	return target

func get_detected():
	return detected

## EXECUTION
func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
