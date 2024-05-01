extends Weapon
class_name  PlasmaGun
@export var projectile_resorce:ProjectileResource
var data:BlockBulletsData2D
@onready var bullet_factory_2d:BulletFactory2D = BulletFactory2d

func _ready():
	super._ready()
	setupData()
	var parent = get_parent() as Entity
	parent.action_signal.connect(shoot)
	bullet_factory_2d.set_is_debugger_enabled(true)

func setupData()->void:
	data = BlockBulletsData2D.new();
	data.textures=projectile_resorce.allTextures
	data.all_bullet_speed_data = [projectile_resorce.speed_data]
	data.collision_layer=BlockBulletsData2D.calculate_bitmask(projectile_resorce.collision_layer)
	data.collision_mask = BlockBulletsData2D.calculate_bitmask(projectile_resorce.collision_mask)
	data.texture_size = projectile_resorce.texture_size
	data.collision_shape_size = projectile_resorce.collision_shape_size
	data.collision_shape_offset=projectile_resorce.collision_shape_offset
	data.max_change_texture_time=projectile_resorce.max_change_texture_time
	data.bullets_custom_data = projectile_resorce.damage_data
	data.monitorable=false
func shoot():
	if(can_shoot):
		data.transforms = get_all_spawn_positions() # set the new transforms
		data.block_rotation_radians=rotation
		
		bullet_factory_2d.spawnBlockBullets2D(data)
		can_shoot=false
		fire_timer.start()


func _on_fire_timer_timeout():
	can_shoot = true 
