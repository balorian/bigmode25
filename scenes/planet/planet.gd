extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loading map " + MapManager.selected_map)
	var scene = load("res://scenes/planet/maps/" + MapManager.selected_map +".tscn")
	var instance = scene.instantiate()
	var map = instance.find_child("TileMapLayer")
	find_child("TileMapLayer").tile_map_data = map.tile_map_data
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
