extends CanvasLayer

export(String) var debug_action := "ui_home"

onready var _fader := $MarginContainer/Fader
onready var _tabs := $MarginContainer/TabContainer

func _ready() -> void:
	assert(InputMap.has_action(debug_action), debug_action + " not in InputMap")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(debug_action):
		_fader.toggle()
