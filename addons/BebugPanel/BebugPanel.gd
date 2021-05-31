extends CanvasLayer
class_name BebugPanel, "icon.png"

export(String) var debug_action := "ui_home"
export (Array, String) var observation_groups := ["DebugPanel"]

onready var _fader := $MarginContainer/Fader
onready var _observer := $MarginContainer/TabContainer/Observer

func _ready() -> void:
	assert(InputMap.has_action(debug_action), debug_action + " not in InputMap")
	_observer.spawn_tree(observation_groups)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(debug_action):
		_fader.toggle()
