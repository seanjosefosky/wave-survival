class_name LevelUpMenu
extends CanvasLayer

var player
var weapon

func setup(p, w):
	player = p
	weapon = w

func _on_button_1_pressed() -> void:
	weapon.enemy_detection.shape.radius *= 1.1
	_choice_made()
	
func _on_button_2_pressed() -> void:
	weapon.attack_speed *= 1.1
	_choice_made()
	
func _on_button_3_pressed() -> void:
	player.speed *= 1.1
	_choice_made()
	
func _choice_made() -> void:
	get_tree().paused = false
	self.queue_free()
	
	
