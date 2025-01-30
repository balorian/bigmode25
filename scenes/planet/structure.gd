extends Node2D

enum State {FALLING, READY}

var state : State = State.FALLING

@export var target = Vector2(0,0)
var tween : Tween = null

@onready var impact_animation = $ImpactAnimation

signal generatePower(amount: int)
var clock : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$debug_label.visible = SettingsManager.debug
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if SettingsManager.debug:
		$debug_label.text = "%v" % position
	
	clock += delta
	if clock >= SettingsManager.tick:
		clock -= SettingsManager.tick
		generatePower.emit(1)
	
	match state:
		State.FALLING:
			if(tween == null):
				tween = get_tree().create_tween()
				tween.set_trans(Tween.TRANS_QUAD)
				tween.set_ease(Tween.EASE_IN)
				tween.tween_property(self, "position", target, 0.2)
				tween.connect("finished", on_tween_finished)
				pass
			pass
		State.READY:
			pass
	pass
	
func on_tween_finished():
	state = State.READY
	impact_animation.visible = true
	impact_animation.play()
	$AudioStreamPlayer2D.play()
