extends Area2D

var speed = 150
var velocity = Vector2()
var target_group_type:String = "enemy"

func _ready():
	$AnimatedSprite2D.play()

func _process(delta):
	position += velocity * delta
	
func _on_area_entered(area):
	if area.is_in_group(target_group_type):
		area.hit()
	
func init(pos, direction):
	position = pos
	velocity = direction * speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
