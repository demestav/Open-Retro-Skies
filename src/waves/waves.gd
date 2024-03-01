extends Node2D

var wave_count = 10

var intro_timer = 3
var outro_timer = 2

var spawn_interval = 0.8 # seconds
var spawn_timer = 0
var spawned_enemies = 0
const ENEMY_SCENE = preload("res://enemy/enemy.tscn")

# @onready var path = get_node("Path2D")
var wave_to_load
var path
var wave_paths
var enemy_path_followers = []

var active_enemies_counter = 0

enum State {
	INTRO,
	IN_PROGRESS,
	OUTRO,
	FINISHED
}

var state = null
var from_state = null
var font


func _ready():	
	start_wave()
	
func start_wave():
	wave_paths = {
		"Wave 1": get_node("Wave 1"),
		"Wave 2": get_node("Wave 2"),
		"Wave 3": get_node("Wave 3"),
		"Wave 4": get_node("Wave 4"),
		"Wave 5": get_node("Wave 5"),
		"Wave 6": get_node("Wave 6"),
		"Wave 7": get_node("Wave 7"),
		"Wave 8": get_node("Wave 8"),
		"Wave 9": get_node("Wave 9"),
		"Wave 10": get_node("Wave 10")
	}
	path = wave_paths[wave_to_load]
	switch_state(State.INTRO)

func _process(delta):
	state_logic(delta)
	state_transition()

func state_logic(delta):
	match state:
		State.INTRO:
			$"Label".text = wave_to_load + "\n" + str(ceili(intro_timer))
			intro_timer -= delta
		State.IN_PROGRESS:
			spawn_timer += delta
			if spawn_timer > spawn_interval and spawned_enemies < wave_count:
				spawn_timer = 0
				spawn_new_enemy()

			active_enemies_counter = 0
			for path_follower in enemy_path_followers:
				var enemy = path_follower.get_child(0)
				if enemy.active == true:
					path_follower.progress_ratio += 0.1 * delta
					active_enemies_counter += 1
		State.OUTRO:
			outro_timer -= delta
		State.FINISHED:
			print("Finished")

func state_transition():
	match state:
		State.INTRO:
			if intro_timer <= 0:
				switch_state(State.IN_PROGRESS)
		State.IN_PROGRESS:
			if active_enemies_counter == 0:
				switch_state(State.OUTRO)
		State.OUTRO:
			if outro_timer <= 0:
				switch_state(State.FINISHED)
		State.FINISHED:
			pass

func switch_state(to_state):
	from_state = state
	state = to_state
	enter(from_state, to_state)


func enter(from_state, to_state):
	match state:
		State.INTRO:
			$"Label".visible = true
		State.IN_PROGRESS:
			$"Label".visible = false
			spawn_new_enemy()
		State.OUTRO:
			$"Label".text = "End of " + wave_to_load
			$"Label".visible = true
		State.FINISHED:
			pass

	
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
	spawned_enemies += 1
	print(len(enemy_path_followers))
