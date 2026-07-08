extends Area2D

@onready var health = player.health

@export var player: Player

signal health_depleted

func take_damage(delta: float) -> void:
	const DAMAGE_RATE = 20.0 # TODO: Calculate this somewhere else
	var enemy_overlapping = get_overlapping_bodies()
	
	if enemy_overlapping:
		@warning_ignore("narrowing_conversion")
		health -= DAMAGE_RATE * enemy_overlapping.size() * delta
		if health >= 0:
			health_depleted.emit()
