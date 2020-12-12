extends Area2D

## VARS
const DEBUG = true
var msg

var target setget set_target, get_target
var detected = []


enum {
	FIRST, # the mob with the least distance to objective
	LAST, # the mob with the most distance to objective
	STRONG, # the mob with the most health
	WEAK # the mob with the least health
}

var mob_priority = FIRST

## FUNCS

func sort_detected():
	#TODO
	pass

func select_target():
	if !detected.empty():
		match mob_priority:
			FIRST:
				set_target(detected[0])
			LAST: 
				set_target(detected[detected.size-1])
			STRONG:
				#TODO
				pass
			WEAK:
				#TODO
				pass

func select_mob_priority(new_mob_priority):
	if new_mob_priority != mob_priority:
		mob_priority = new_mob_priority
		
## SIGNALS
func _on_body_entered(body):
	msg = ""
	if "mob_type" in body:
		msg = "[dbg] {%s} detected collision with {%s}, a mob of type \"%s\"." % [self, body, body.get_mob_type()]
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

func _physics_process(_delta):
	select_target()
