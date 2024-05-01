extends Node2D
class_name Gun
signal shot_action()
@onready var markers_cotainer:Node2D = %"Markers cotainer"
@onready var fire_timer:Timer = %FireTimer
@onready var reload_timer:Timer = %ReloadTimer
@onready var bullet_factory_2d:BulletFactory2D = BulletFactory2d
@export var gun_resource:GunResource
@export var projectile_resource:ProjectileResource
var max_ammo:int
var ammo:int
var data:BlockBulletsData2D
var can_shoot=true
var cached_markers:Array[Node2D]
var is_reloading:bool=false
var spawn_points_count:int=0
func _ready():
	max_ammo = gun_resource.max_ammo
	ammo= gun_resource.max_ammo
	fire_timer.wait_time=gun_resource.time_between_shots
	reload_timer.wait_time=gun_resource.reload_time
	for marker:Node2D in markers_cotainer.get_children():
		cached_markers.append(marker)
		spawn_points_count+=1
	setupData()
	var parent = get_parent() as Entity
	parent.action_signal.connect(shoot)

func setupData()->void:
	data = BlockBulletsData2D.new();
	data.max_life_time = projectile_resource.life_time
	data.textures=projectile_resource.allTextures
	var speed_data=[]
	for point in range(0,spawn_points_count):
		speed_data.append(projectile_resource.speed_data)
	data.all_bullet_speed_data = speed_data
	data.collision_layer=BlockBulletsData2D.calculate_bitmask(projectile_resource.collision_layer)
	data.collision_mask = BlockBulletsData2D.calculate_bitmask(projectile_resource.collision_mask)
	data.texture_size = projectile_resource.texture_size
	data.collision_shape_size = projectile_resource.collision_shape_size
	data.collision_shape_offset=projectile_resource.collision_shape_offset
	data.max_change_texture_time=projectile_resource.max_change_texture_time
	data.bullets_custom_data = projectile_resource.damage_data
	data.monitorable=false

func get_all_spawn_positions()->Array[Transform2D]:
	var transf:Array[Transform2D] = [];
	for child:Node2D in cached_markers:
		transf.push_back(child.get_global_transform())
	return transf;

func shoot():
	
	shot_action.emit()
	
	if(can_shoot and !is_reloading):
		ammo-=1
		data.transforms = get_all_spawn_positions() # set the new transforms
		data.block_rotation_radians=rotation
		bullet_factory_2d.spawnBlockBullets2D(data)
		can_shoot=false
		fire_timer.start()
		if(ammo==0):
			print("reload")
			is_reloading=true
			reload_timer.start()


func _on_fire_timer_timeout():
	can_shoot=true


func _on_reload_timer_timeout():
	ammo=max_ammo
	print("reload comeplite")
	is_reloading=false
