extends Node2D

var planets
var connections

var selected_planet

@onready var launch_button = $CanvasLayer/Control/VBoxContainer/HBoxContainer/LaunchButton
@onready var win_button = $CanvasLayer/Control/VBoxContainer/HBoxContainer/WinButton


# Called when the node enters the scene tree for the first time.
func _ready():
	planets = find_child("planets").get_children()
	connections = find_child("connections").get_children()
	
	configureSelections()
	
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

func _on_launch_button_pressed():
	SceneManager.switchTo("planet/planet")

func _on_win_button_pressed():
	var win_audio = $AudioStreamPlayer2D
	win_audio.play()
	await get_tree().create_timer(win_audio.stream.get_length() + .1).timeout
	PlayerData.completedPlanet = 0
	SceneManager.switchTo("start_screen/start_screen")

func configureSelections():
	var lastPlanet = PlayerData.completedPlanet
	
	print("last completed planet = %d" % lastPlanet)

	if lastPlanet == 0:
		planets[0].disabled = false
		for connection in connections:
			connection.default_color = Color.GRAY
	elif lastPlanet == 7:
		win_button.disabled = false
	else:
		for planet in planets:
			planet.disabled = true
		for connection in connections:
			connection.default_color = Color.GRAY
			if connection.start_planet == lastPlanet:
				connection.default_color = Color.YELLOW
				planets[connection.destination_planet - 1].disabled = false
