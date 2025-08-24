extends Node

@export var default_texture: Texture
@export var base_cursor_size := 32
var scale_multiplier := 1
var cursor_size: int:
	get():
		return scale_multiplier * base_cursor_size
var cursor_offset: float:
	get():
		return cursor_size / 2.0


func _ready() -> void:
	_update_cursors()
	
	
func _update_cursors() -> void:
	Controller.connect("input_method_changed",_on_input_method_changed)
	Input.set_custom_mouse_cursor(default_texture, Input.CURSOR_ARROW, Vector2(cursor_offset, cursor_offset))
	Input.set_custom_mouse_cursor(default_texture, Input.CURSOR_POINTING_HAND, Vector2(cursor_offset, cursor_offset))
	
func _on_input_method_changed(using_controller: bool):
	print("changing cursor ",using_controller)
	if using_controller:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
