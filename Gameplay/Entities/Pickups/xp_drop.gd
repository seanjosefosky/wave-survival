class_name XpDrop
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("xp_collect"):
			body.xp_collect()
		queue_free()
