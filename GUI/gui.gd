extends CanvasLayer

@onready var kills_label: Label = $ColorRect/Kills

func _process(delta: float) -> void:
	kills_label.text = "Kills: %s" % PlayerGlobals.kills
