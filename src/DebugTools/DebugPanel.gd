extends CanvasLayer

onready var _fader := $MarginContainer/Fader
onready var _tabs := $MarginContainer/TabContainer

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug"):
		_fader.toggle()
