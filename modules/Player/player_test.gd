extends Node2D

@export var player:PackedScene
@onready var entity_controller:EntityController = $EntityController

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_instance=player.instantiate() as Player
	add_child(player_instance)
	entity_controller.entity=player_instance

