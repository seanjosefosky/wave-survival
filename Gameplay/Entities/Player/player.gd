class_name Player
extends CharacterBody2D

@export var stats: CharacterStats

@onready var health = stats.max_health
@onready var speed = stats.move_speed
@onready var health_bar: TextureProgressBar = $HealthBar

var xp := 0
var xp_needed := 5
var level := 1


func _ready() -> void:
	pass

func _physics_process(delta: float):
	get_input()
	move_and_slide()
	health_regen()

## Player controls
func get_input():
	var input_direction = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down"
	)
	velocity = input_direction * speed

## Player collects xp
func xp_collect() -> void:
	xp += 1
	if xp == xp_needed:
		level_up()

## Handles xp values and level ups
func level_up() -> void:
	level += 1
	xp_needed += 10
	xp = 0
	get_tree().paused = true
	var level_up_menu = preload("res://GUI/level_up_menu.tscn").instantiate()
	get_node("/root/World").add_child(level_up_menu)
	level_up_menu.setup(self, $WeaponBase)

## Player takes (amount) damage
func apply_damage(amount):
	health -= amount
	if health <= 0:
		death()

## regen per second
func health_regen():
	var amount = stats.health_regen
	if health < stats.max_health:
		health += amount
		await get_tree().create_timer(1).timeout

## RIP
func death() -> void:
	# TODO: Death Animation
	get_tree().paused = true
	
	var death_menu = preload("res://GUI/player_died_screen.tscn").instantiate()
	get_node("/root/World").add_child(death_menu)
