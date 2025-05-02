extends Node

signal input_method_changed(using_controller: bool)

var using_controller = false

func _input(event):
	var _using_controller = using_controller
	
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		_using_controller = true
	else:
		_using_controller = false
	
	if _using_controller != using_controller:
		using_controller = _using_controller
		
		input_method_changed.emit(using_controller)
