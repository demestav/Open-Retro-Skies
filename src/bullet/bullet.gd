extends Area2D

var speed = 150
var velocity = Vector2()

func _ready():
	$AnimatedSprite2D.play()

func _process(delta):
	position += velocity * delta
	
func _on_body_entered(body):
	pass
	
func _on_area_entered(area):
	if area.name == "enemy":
		area.destroy()
	
func init(pos, direction):
	position = pos
	velocity = direction * speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
