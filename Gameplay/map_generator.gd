class_name MapGenerator
extends Node2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer

@export var map_height := 128
@export var map_width := 256	
@export var noise_scale := 0.12

@export_range(0.0, 1.0) var deep_water_threshold = 0.5
@export_range(0.0, 1.0) var water_threshold = 0.5
@export_range(0.0, 1.0) var coast_threshold = 0.5
@export_range(0.0, 1.0) var inland_threshold = 0.5
@export_range(0.0, 1.0) var hill_threshold = 0.5
@export_range(0.0, 1.0) var mountain_threshold = 0.5
@export_range(0.0, 1.0) var mountain_peak_threshold = 0.5



func _ready() -> void:
	generate_map()

func generate_map() -> void:
	var perlin_noise = FastNoiseLite.new()
	perlin_noise.seed = randi()
	perlin_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	perlin_noise.frequency = noise_scale
	
	
	tile_map_layer.clear()
	
	for x in range(map_width):
		for y in range(map_height):
			var noise_value = perlin_noise.get_noise_2d(x, y)
			noise_value = (noise_value + 1) / 2
			
			var tile_pos := Vector2i(x, y)
			var atlas_coords := Vector2i(0, 0)
			
			if noise_value <= deep_water_threshold:
				atlas_coords = Vector2i(6, 0)
			elif noise_value <= water_threshold:
				atlas_coords = Vector2i(5, 0)
			elif noise_value <= coast_threshold:
				atlas_coords = Vector2i(4, 0)
			elif noise_value <= inland_threshold:
				atlas_coords = Vector2i(3, 0)
			elif noise_value <= hill_threshold:
				atlas_coords = Vector2i(2, 0)
			elif noise_value <= mountain_threshold:
				atlas_coords = Vector2i(1, 0)
			elif noise_value <= mountain_peak_threshold:
				atlas_coords = Vector2i(0, 0)
			tile_map_layer.set_cell(tile_pos, 0, atlas_coords)
