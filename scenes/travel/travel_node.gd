extends Node2D

@export var map_name : String

@onready var focus = $focus_animation

signal planet_selected(map_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_focused(value):
	focus.visible = value

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		planet_selected.emit(map_name)
