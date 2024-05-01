extends Entity
class_name Player
@export var resource:PlayerResource
var health:int 
var max_speed:float
var min_speed:float
var current_speed:float
var delta:float

func _ready():
	health = resource.max_health
	max_speed = resource.max_speed
	min_speed = resource.min_speed
	current_speed = min_speed
	delta = max_speed/4

func move(direction:Vector2):
	if direction != Vector2.ZERO:
		current_speed=move_toward(current_speed, max_speed,delta)
	else:
		current_speed=move_toward(current_speed, 0,delta)
	velocity=direction*current_speed
	move_and_slide()

func dash():
	print("dash")
func action():
	action_signal.emit()
func interact():
	print("interact")
