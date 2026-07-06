extends Node2D

@export var player: Player

func _ready() -> void:
	get_tree().paused = false

func _process(_delta: float) -> void:
	$UI/XPBar.value = player.xp
	$UI/XPBar.max_value = player.xp_needed
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		toggle_pause()
	
func toggle_pause():
	get_tree().paused = !get_tree().paused
	$PauseMenu.visible = get_tree().paused
