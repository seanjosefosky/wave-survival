class_name UICanvas extends CanvasLayer

@export var player: Player

@onready var label: Label = $XPBar/CenterContainer/Label

func _process(delta: float) -> void:
	label.text = "lvl: %s" % player.level
