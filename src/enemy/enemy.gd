extends Area2D

const BULLET = preload("res://bullet/bullet.tscn")
@onready var radar = $RayCast2D
var ammo = 1
var cooldown = 1
var active = false

func _ready():
	active = true

func _process(delta):
	if cooldown < 1:
		cooldown += delta
	if radar.is_colliding():
		if cooldown >= 1 and ammo > 0:
			fire_bullet()
	
func hit():
	print("I was hit!")
	active = false

func fire_bullet():
	cooldown = 0
	ammo -= 1
	var bul = BULLET.instantiate()
	bul.set_collision_mask_value(1, true)
	bul.set_collision_mask_value(2, false)
	var dir = Vector2(1, 0).rotated(global_rotation)
	bul.rotation = dir.angle()
	bul.target_group_type = "player"
	bul.init(global_position, dir)
	get_tree().get_root().get_node("Level").add_child(bul)
