extends Node2D

var planets
var selected_planet
@onready var launch_button = $CanvasLayer/Control/LaunchButton

# Called when the node enters the scene tree for the first time.
func _ready():
	planets = find_child("planets").get_children()
	pass # Replace with function body.

func select_planet(planet):
	selected_planet = planet
	MapManager.selected_map = planet.map_name
	launch_button.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	pass

func _on_planet_planet_selected(map_name):
	for planet in planets:
		if(planet.map_name == map_name):
			planet.set_focused(true)
			select_planet(planet)
		else:
			planet.set_focused(false)
	print("selected planet " + map_name)
	pass # Replace with function body.


func _on_launch_button_pressed():
	SceneManager.switchTo("planet/planet")
	pass # Replace with function body.
