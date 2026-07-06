class_name Player
extends CharacterBody2D

signal health_depleted

@export var health := 10.0
@export var speed := 100.0

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hurt_box: Area2D = $HurtBox
@onready var xp_box: Area2D = $XpBox
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $PlayerSprite


var xp := 0
var xp_needed := 5


func _ready() -> void:
	$HealthBar.value = health
	$HealthBar.max_value = health
	
func _physics_process(delta: float):
	get_input()
	move_and_slide()
	take_damage(delta)
	
	PlayerGlobals.position = global_position
	
	
		
func get_input():
	var input_direction = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down"
	)
	velocity = input_direction * speed

func take_damage(delta: float) -> void:
	const DAMAGE_RATE = 20.0
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	
	if overlapping_mobs:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		if health >= 0.0:
			health_depleted.emit()
			animation.play("take_damage")
			$HealthBar.value = health
		elif health <= 0:
			get_tree().change_scene_to_file("uid://dp0h2ayn1r6dw")
			
	elif not overlapping_mobs:
		animation.play("normal")
		animation.stop()
		
func xp_collect() -> void:
	xp += 1
	if xp == xp_needed:
		level_up()

func level_up() -> void:
	xp_needed += 10
	xp = 0
	get_tree().paused = true
	var level_up_menu = preload("res://GUI/level_up_menu.tscn").instantiate()
	get_node("/root/World").add_child(level_up_menu)
	level_up_menu.setup(self, $Weapon)
