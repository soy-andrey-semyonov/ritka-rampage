extends CanvasLayer

@export var settings_scene: PackedScene
@export var main_scene: PackedScene

@onready var play_button: Button = %PlayButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton
@onready var margin_container: MarginContainer = $MarginContainer


func _ready() -> void:
	play_button.grab_focus()  # Set initial focus
	play_button.pressed.connect(on_play_pressed)
	settings_button.pressed.connect(on_settings_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	
func on_play_pressed():
	get_tree().change_scene_to_packed(main_scene)
	

func on_settings_pressed():
	var settings_menu_instance = settings_scene.instantiate() as SettingsMenu
	add_child(settings_menu_instance)
	settings_menu_instance.set_ui_position(Constants.UIPositions.RIGHT)
	
	settings_menu_instance.back_pressed.connect(on_settings_back_pressed.bind(settings_menu_instance))
	
func on_settings_back_pressed(settings_menu: SettingsMenu):
	settings_menu.queue_free()
	settings_button.grab_focus()

func on_quit_pressed():
	get_tree().quit()
	
