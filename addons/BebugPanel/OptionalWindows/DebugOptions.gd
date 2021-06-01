extends Tabs

onready var _time_label := $VBoxContainer/TimeScale/value


func _ready() -> void:
	_on_HSlider_value_changed(Engine.time_scale)


func _on_HSlider_value_changed(value: float) -> void:
	Engine.time_scale = value
	_time_label.text = str(value) + "x"


func _on_ReloadScene_pressed() -> void:
	get_tree().reload_current_scene()


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
