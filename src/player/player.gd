extends CharacterBody2D
@onready var animation_player = $AnimationPlayer

enum State {
	IDLE,
	ROLL_RIGHT_1,
	ROLL_RIGHT_2,
	ROLL_LEFT_1,
	ROLL_LEFT_2,
	LOOP
}

var state = State.IDLE
var from_state = null


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_logic()
	state_transition()
	move_and_slide()

func state_logic():
	match state:
		State.IDLE:
			velocity.x = lerpf(velocity.x, 0, 0.5)
		State.ROLL_RIGHT_1:
			velocity.x = lerpf(velocity.x, 30, 0.5)
		State.ROLL_RIGHT_2:
			velocity.x = lerpf(velocity.x, 50, 0.7)
		State.ROLL_LEFT_1:
			velocity.x = lerpf(velocity.x, -30, 0.5)
		State.ROLL_LEFT_2:
			velocity.x = lerpf(velocity.x, -50, 0.7)
		State.LOOP:
			pass

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
		State.LOOP:
			pass

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
		State.LOOP:
			pass
