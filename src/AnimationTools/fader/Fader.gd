extends Tween

export var _faded := true setget set_faded
export var _duration := 0.2

func _ready() -> void:
	assert(get_parent().get("modulate") and get_parent().get("visible"))
	if _faded:
		get_parent().modulate = Color.transparent
		get_parent().visible = false
		
func set_faded(should_fade_out: bool) -> void:
	fade_out() if should_fade_out else fade_in()
		
func toggle() -> void:
	fade_in() if _faded else fade_out()

func fade_in() -> void:
	_faded = false
	stop_all()
	get_parent().visible = true
	interpolate_property(get_parent(), "modulate", get_parent().modulate, Color.white, _duration)
	start()
	
func fade_out() -> void:
	_faded = true
	stop_all()
	interpolate_property(get_parent(), "modulate", get_parent().modulate, Color.transparent, _duration)
	start()

func _on_Fader_tween_completed(_object: Object, _key: NodePath) -> void:
	get_parent().visible = not _faded
