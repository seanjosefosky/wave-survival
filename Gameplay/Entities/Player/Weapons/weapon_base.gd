class_name WeaponBase
extends Area2D

@export var stats: WeaponStats

@onready var shooting_point: Marker2D = $WeaponPivot/ShootingPoint
@onready var shoot_timer: Timer = $ShootTimer
@onready var enemy_detection: CollisionShape2D = $EnemyDetection


func _ready() -> void:
	shoot_timer.wait_time = stats.attack_speed

func _physics_process(_delta: float) -> void:
	get_closest_enemy()

func get_closest_enemy() -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() == 0:
		return

	var closest_enemy: Enemy = null
	var closest_dist := INF

	for enemy in enemies_in_range:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest_enemy = enemy

	if closest_enemy:
		look_at(closest_enemy.global_position)
		
func calculate_damage() -> float:
	var damage: float
	var base_damage: int = randi_range(0, stats.max_damage)
	var roll_crit = randf_range(0, stats.crit_chance)
	
	if roll_crit <= stats.crit_chance:
		damage = base_damage * stats.crit_multiplier
		print("CRIT")
	else: 
		damage = base_damage
		
	return damage
	
func shoot() -> void:
	var projectile = preload("uid://o0o3bwswc4qg")
	var new_projectile = projectile.instantiate()
	new_projectile.global_position = shooting_point.global_position
	new_projectile.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_projectile)
	new_projectile.damage = calculate_damage()

func _on_shoot_timer_timeout() -> void:
		shoot()
