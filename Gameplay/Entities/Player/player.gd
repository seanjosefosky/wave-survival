class_name Player
extends CharacterBody2D

@export var stats: CharacterStats

var health = stats.max_health
var xp := 0
var xp_needed := 5
var level := 1

func _ready() -> void:
	pass
	
func _physics_process(delta: float):
	get_input()
	move_and_slide()
	
	#TODO: player death -> get_tree().change_scene_to_file("uid://dp0h2ayn1r6dw")
	
func get_input():
	var input_direction = Input.get_vector(
		"move_left", 
		"move_right", 
		"move_up", 
		"move_down"
	)
	velocity = input_direction * stats.speed

func xp_collect() -> void:
	stats.xp += 1
	if xp == xp_needed:
		level_up()

func level_up() -> void:
	xp_needed += 10
	xp = 0
	get_tree().paused = true
	var level_up_menu = preload("res://GUI/level_up_menu.tscn").instantiate()
	get_node("/root/World").add_child(level_up_menu)
	level_up_menu.setup(self, $Weapon)
