class_name Enemy
extends CharacterBody2D

@onready var player := get_node("/root/World/Player")
@onready var animation: AnimationPlayer = $AnimationPlayer

var speed := randf_range(50.0, 60.0)
var health := 10.0


func _physics_process(_delta):
	var direction = global_position.direction_to(player.position)
	velocity = direction * speed
	move_and_slide()

func take_damage(dmg):
	animation.play("take_damage")
	health -= dmg
	if health <= 0:
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
