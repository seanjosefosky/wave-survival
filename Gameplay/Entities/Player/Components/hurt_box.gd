extends Area2D

@onready var player: Player = $".."

func _physics_process(delta: float) -> void:
	take_damage(delta)

func take_damage(delta: float) -> void:
	var enemy_overlapping = get_overlapping_bodies()
	var damage = 30.0
	
	if enemy_overlapping:
		player.apply_damage(damage * enemy_overlapping.size() * delta)
