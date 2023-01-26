extends Area2D

@onready var animation_player = $AnimationPlayer
const BULLET = preload("res://bullet/bullet.tscn")
var velocity = Vector2(0, 0)
const MAX_SPEED = 100

enum State {
	IDLE,
	ROLL_RIGHT_1,
	ROLL_RIGHT_2,
	ROLL_LEFT_1,
	ROLL_LEFT_2,
}

var state = State.IDLE
var from_state = null
var screen_size

func _ready():
	screen_size = get_viewport_rect().size	
	animation_player.play("Idle")

func _process(delta):
	# Events
	process_events()
	
	# Movement	
	state_logic()
	state_transition()
	position.x = clamp(position.x, 0, screen_size.x)
	position += velocity * delta

func state_logic():
	match state:
		State.IDLE:
			pass
		State.ROLL_RIGHT_1:
			pass
		State.ROLL_RIGHT_2:
			pass
		State.ROLL_LEFT_1:
			pass
		State.ROLL_LEFT_2:
			pass
	
	# In all states the player can control the character
	if Input.is_action_pressed("ui_right"):
		velocity.x = lerpf(velocity.x, MAX_SPEED, 0.1)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = lerpf(velocity.x, -MAX_SPEED, 0.1)
	else:
		velocity.x = lerpf(velocity.x, 0, 0.1)
	
func state_transition():
	match state:
		State.IDLE:
			if Input.is_action_pressed("ui_right"):
				switch_state(State.ROLL_RIGHT_1)
			elif Input.is_action_pressed("ui_left"):
				switch_state(State.ROLL_LEFT_1)
		State.ROLL_RIGHT_1:
			if not Input.is_action_pressed("ui_right") and not animation_player.is_playing():
				switch_state(State.IDLE)
			else:
				if not animation_player.is_playing():
					switch_state(State.ROLL_RIGHT_2)
		State.ROLL_RIGHT_2:
			if not Input.is_action_pressed("ui_right"):
				switch_state(State.ROLL_RIGHT_1)
		State.ROLL_LEFT_1:
			if not Input.is_action_pressed("ui_left") and not animation_player.is_playing():
				switch_state(State.IDLE)
			else:
				if not animation_player.is_playing():
					switch_state(State.ROLL_LEFT_2)
		State.ROLL_LEFT_2:
			if not Input.is_action_pressed("ui_left"):
				switch_state(State.ROLL_LEFT_1)

func switch_state(to_state):
	from_state = state
	state = to_state
	enter(from_state, to_state)

func enter(from_state, to_state):
	match state:
		State.IDLE:
			animation_player.play("Idle")
		State.ROLL_RIGHT_1:
			if from_state == State.IDLE:
				animation_player.play("Right Roll 1")
			elif from_state == State.ROLL_RIGHT_2:
				animation_player.play_backwards("Right Roll 1")
		State.ROLL_RIGHT_2:
			animation_player.play("Right Roll 2")
		State.ROLL_LEFT_1:
			if from_state == State.IDLE:
				animation_player.play("Left Roll 1")
			elif from_state == State.ROLL_LEFT_2:
				animation_player.play_backwards("Left Roll 1")
		State.ROLL_LEFT_2:
			animation_player.play("Left Roll 2")

func fire_bullet():
	var bul = BULLET.instantiate()
	var dir = Vector2(1, 0).rotated(global_rotation)
	bul.rotation = dir.angle()
	bul.init(position, dir)
	get_tree().get_root().add_child(bul)

	
func process_events():
	if Input.is_action_just_pressed("action A"):
		fire_bullet()
		
