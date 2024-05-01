extends Node2D
class_name Weapon
signal shot_action()
@onready var markers_cotainer = %"Markers cotainer"
@onready var fire_timer = %FireTimer
var can_shoot=true
var cached_markers:Array[Node2D]
func _ready():
	for marker:Node2D in markers_cotainer.get_children():
		cached_markers.append(marker)

func get_all_spawn_positions()->Array[Transform2D]:
	var transf:Array[Transform2D] = [];
	for child:Node2D in cached_markers:
		transf.push_back(child.get_global_transform())
	return transf;

func shot():
	shot_action.emit()
	pass
