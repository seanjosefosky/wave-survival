class_name Enemy
extends CharacterBody2D

@export var stats: EnemyStats
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var player := get_node("/root/World/Player")
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sprite_2d.texture = stats.sprite

func _physics_process(_delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * stats.speed
	move_and_slide()

## Handles enemy damage and death
func take_damage(dmg):
	animation.play("take_damage")
	stats.health -= dmg
	if stats.health <= 0:
		var pos := global_position
		spawn_xp(pos)
		queue_free()

func spawn_xp(pos) -> void:
	var xp_drop = preload("uid://bdecn072k6arv").instantiate()
	xp_drop.position = pos
	get_node("/root/World").call_deferred("add_child", xp_drop)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "take_damage":
		animation.play("normal")
		animation.stop()
