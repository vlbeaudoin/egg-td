extends Area2D

## VARS
const DEBUG = false
var msg

var target setget set_target, get_target
var detected = []


enum {
	FIRST, # the mob with the least distance to objective
	LAST, # the mob with the most distance to objective
	STRONG, # the mob with the most health
	WEAK # the mob with the least health
}


export var mob_priority := FIRST setget set_mob_priority, get_mob_priority
#TODO make this a dynamic option

## FUNCS
func sort_detected():
	if detected.size() > 1:
		if DEBUG:
			print("Detected[] pre-sort: ")
			for detected_mob in detected:
				print("Mob distance: ", detected_mob.get_distance())

		detected.sort_custom(CustomSorterDistance, "sort_distance_ascending")
		
		if DEBUG:
			print("Detected[] post-sort: ", detected)
			for detected_mob in detected:
				print("Mob distance: ", detected_mob.get_distance())

class CustomSorterDistance:
	static func sort_distance_ascending(a, b):
		var value = false
		
		if a != null and b != null:
			
			var distance_a = a.distance
			var distance_b = b.distance
			
			if distance_a == null:
				distance_a = 0.0
			
			if distance_b == null:
				distance_b = 0.0
			
			if distance_a < distance_b:
				value = true
				
		return value

func select_target():
	if !detected.empty():
		match mob_priority:
			FIRST:
				set_target(detected[0])
			LAST: 
				set_target(detected[detected.size()-1])
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
		if DEBUG:
			msg = "[dbg] {%s} detected collision with {%s}, a mob of type \"%s\"." % [self, body, body.get_mob_type()]
			print(msg)
		
		detected.append(body) # add the body to the detected array
		sort_detected() # sort the detected array
		

func _on_body_exited(body):
	if body == target:
		set_target(null)
	
	# Remove the leaving body from the detected array
	for mob in detected:
		if mob == body:
			detected.erase(mob)


## SETGET
func set_target(new_target):
	if target != new_target:
		target = new_target

func get_target():
	return target

func get_detected():
	return detected

func set_mob_priority(new_mob_priority):
	if mob_priority != new_mob_priority:
		mob_priority = new_mob_priority

func get_mob_priority():
	return mob_priority
	
## EXECUTION
func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _physics_process(_delta):
	sort_detected()
	select_target()
