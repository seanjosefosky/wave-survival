extends TextureProgressBar

@export var player: Player


func _ready() -> void:
	max_value = player.stats.max_health

func _process(_delta: float) -> void:
	value = player.health
