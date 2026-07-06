extends CanvasLayer


func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false
	

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("uid://drmb12noedd7r")
