extends Node2D


@onready var tileMapLayer = $TileMapLayer

var structure_scene : PackedScene
var strucures : Node2D

var debug : bool = true

@onready var planetary_power_bar = $CanvasLayer/MarginContainer/PanelContainer2/MarginContainer/HBoxContainer/PanelContainer2/VBoxContainer/PlanetaryPowerBar
@onready var launch_button = $CanvasLayer/MarginContainer/PanelContainer2/MarginContainer/HBoxContainer/PanelContainer2/VBoxContainer/LaunchButton

var planet_id = 0

var clock : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("loading map " + MapManager.selected_map)
	var scene = load("res://scenes/planet/maps/" + MapManager.selected_map +".tscn")
	var instance = scene.instantiate()
	var map = instance.find_child("TileMapLayer")
	find_child("TileMapLayer").tile_map_data = map.tile_map_data
	
	structure_scene = load("res://scenes/planet/structure.tscn")
	strucures = $structures
	
	planetary_power_bar.max_value = instance.liftoff_energy
	planet_id = instance.planet_id
	
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
		var target_pos = tileMapLayer.map_to_local(clicked_cell)
		
		var building = structure_scene.instantiate()
		building.target = target_pos
		building.position = target_pos - Vector2(0, 300)
		building.generatePower.connect(addPower)
		strucures.add_child(building)
		
		pass

func addPower(amount : int):
	planetary_power_bar.value += amount
	if planetary_power_bar.value == planetary_power_bar.max_value:
		launch_button.disabled = false
	else:
		launch_button.disabled = true


func _on_launch_button_pressed():
	PlayerData.completedPlanet = planet_id
	SceneManager.switchTo("travel/travel_selection")
	pass # Replace with function body.
