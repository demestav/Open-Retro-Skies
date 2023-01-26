extends Area2D

const BULLET = preload("res://bullet/bullet.tscn")
@onready var radar = $RayCast2D
var ammo = 1
var cooldown = 1

func _ready():
	pass

func _process(delta):
	if cooldown < 1:
		cooldown += delta
	if radar.is_colliding():
		if cooldown >= 1 and ammo > 0:
			fire_bullet()
	
func destroy():
	queue_free()

func fire_bullet():
	cooldown = 0
	ammo -= 1
	var bul = BULLET.instantiate()
	var dir = Vector2(1, 0).rotated(global_rotation)
	bul.rotation = dir.angle()
	bul.init(global_position, dir)
	get_tree().get_root().get_node("Level").add_child(bul)
