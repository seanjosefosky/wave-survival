class_name Weapon
extends Area2D

@onready var shooting_point: Marker2D = $WeaponPivot/ShootingPoint
@onready var shoot_timer: Timer = $ShootTimer

var attack_speed := 1.0

func _ready() -> void:
	shoot_timer.wait_time = attack_speed

func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy: Enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		

func shoot() -> void:
	const BULLET = preload("uid://o0o3bwswc4qg")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_bullet)


func _on_shoot_timer_timeout() -> void:
	shoot()
