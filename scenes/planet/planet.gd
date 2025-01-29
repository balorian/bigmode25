extends Node2D

@onready var tileMapLayer = $TileMapLayer

var structure_scene : PackedScene
var strucures : Node2D

var debug : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loading map " + MapManager.selected_map)
	var scene = load("res://scenes/planet/maps/" + MapManager.selected_map +".tscn")
	var instance = scene.instantiate()
	var map = instance.find_child("TileMapLayer")
	find_child("TileMapLayer").tile_map_data = map.tile_map_data
	
	structure_scene = load("res://scenes/planet/structure.tscn")
	strucures = $structures
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if debug :
		var tile_coord = tileMapLayer.local_to_map(tileMapLayer.get_local_mouse_position())
		var target_pos = tileMapLayer.map_to_local(tile_coord)
		
		$CanvasLayer/MarginContainer/PanelContainer2/MarginContainer/HBoxContainer/mouse_loc_label.text = "%v \n %v" % [tile_coord, target_pos]
	if event is InputEventMouseButton and event.is_released():
		var pos = event.position
		var clicked_cell = tileMapLayer.local_to_map(tileMapLayer.get_local_mouse_position())
		print("clicked cell %v" % clicked_cell)
		var target_pos = tileMapLayer.map_to_local(clicked_cell)
		
		var building = structure_scene.instantiate()
		building.target = target_pos
		building.position = target_pos - Vector2(0, 300)
		strucures.add_child(building)
		
		pass
