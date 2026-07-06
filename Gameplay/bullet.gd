class_name Bullet
extends Area2D
	
const SPEED = 1000
const RANGE = 1200
	
var travelled_distance = 0
var damage := 5.0
	
func _physics_process(delta):
	var direction := Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
