extends CanvasLayer

@onready var high_score = $MarginContainer/VBoxContainer/HighScoreLabel

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("uid://drmb12noedd7r")


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("uid://dehljd47hc86v")


func _on_quit_game_pressed() -> void:
	get_tree().quit()
