extends Node2D

var wave_count = 10
var spawn_interval = 0.8 # seconds
var spawn_timer = 0
var spawned_enemies = 0
const ENEMY_SCENE = preload("res://enemy/enemy.tscn")

@onready var path = get_node("Path2D")
var enemy_path_followers = []

func _ready():	
	pass

func _process(delta):
	spawn_timer += delta
	if spawn_timer > spawn_interval and spawned_enemies < wave_count:
		spawn_timer = 0
		spawn_new_enemy()
		spawned_enemies += 1
	
	for path_follower in enemy_path_followers:
		path_follower.progress_ratio += 0.1 * delta


func spawn_new_enemy():
	"""
	Add new path follower and attach it to the path. Then attach the
	emeny on that path follower.
	"""
	var new_path_follower = PathFollow2D.new()
	new_path_follower.loop = false
	path.add_child(new_path_follower)
	var enemy = ENEMY_SCENE.instantiate()
	new_path_follower.add_child(enemy)
	enemy_path_followers.append(new_path_follower)
