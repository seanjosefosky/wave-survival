class_name LevelUpMenu
extends CanvasLayer

@onready var weapon := get_node("uid://dycqa4u32ryt7")
@onready var bullet := get_node("uid://o0o3bwswc4qg")
@onready var player := get_node("uid://c6uk8ka7fb3lc")

signal choice_made

func _on_button_1_pressed() -> void:
	bullet.damage *= 0.1
	choice_made.emit()
	
func _on_button_2_pressed() -> void:
	weapon.attack_speed *= 0.1
	choice_made.emit()
	
func _on_button_3_pressed() -> void:
	player.speed *= 0.1
	choice_made.emit()

func _on_choice_made() -> void:
	get_tree().paused = false
	self.queue_free()
	
	
