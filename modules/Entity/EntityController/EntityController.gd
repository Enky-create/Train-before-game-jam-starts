extends Node2D
class_name EntityController
@export var entity:Entity:
	get:
		return entity
	set(value):
		entity = value

func _ready():
	pass

func _physics_process(_delta):
	if(entity):
		var input = Input.get_vector("left","right","up","down")
		entity.move(input)
		if(Input.is_action_just_pressed("dash")):
			entity.dash()
		if(Input.is_action_pressed("action")):
			entity.action()
		if(Input.is_action_just_pressed("interact")):
			entity.interact()
		entity.look_at(get_global_mouse_position())
