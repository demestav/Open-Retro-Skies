extends Area2D

@onready var speed = 150

func _ready():
	$AnimatedSprite2D.play()

func _process(delta):
	position.y = position.y - speed*delta

func _on_body_entered(body):
	print("HIT")
	print(body)
