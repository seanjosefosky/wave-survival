class_name Enemy
extends CharacterBody2D

@onready var player := get_node("/root/World/Player")
@onready var animation: AnimationPlayer = $AnimationPlayer

var speed := 55.0
var health := 10.0


func _physics_process(_delta):
	var direction = global_position.direction_to(player.position)
	velocity = direction * speed
	move_and_slide()

func take_damage(dmg):
	animation.play("take_damage")
	health -= dmg
	if health <= 0:
		spawn_xp()
		queue_free()
		PlayerGlobals.kills += 1

func spawn_xp() -> void:
	var pos := global_position
	var xp_drop = preload("uid://bdecn072k6arv").instantiate()
	xp_drop.position = pos
	get_node("/root/World").add_child(xp_drop)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "take_damage":
		animation.play("normal")
		animation.stop()
