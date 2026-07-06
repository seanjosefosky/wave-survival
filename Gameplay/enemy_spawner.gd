class_name EnemySpawner
extends Node2D

@export var enemies: Node2D
@export var spawn_curve: Curve

@onready var spawn_timer: Timer = $SpawnTimer

var play_time := 0

func _physics_process(_delta: float) -> void:
	global_position = PlayerGlobals.position
	spawn_timer.wait_time = spawn_curve.sample(play_time)
	
func _on_spawn_timer_timeout() -> void:
	var enemy := preload("uid://c2eb18u0y45mh").instantiate()
	var enemy_spawn: PathFollow2D = $SpawnPath/EnemySpawn
	
	enemy_spawn.progress_ratio = randf()
	enemy.position = enemy_spawn.global_position

	enemies.add_child(enemy)


func _on_play_time_timeout() -> void:
	play_time += 1
