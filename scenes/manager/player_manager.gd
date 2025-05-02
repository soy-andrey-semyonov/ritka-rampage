class_name PlayerManager
extends Node

@onready var player_scene = preload("res://scenes/game_object/player/player.tscn")
var current_player_count := 0

func _ready():
	spawn_player(1, Vector2(100, 100))
	
func spawn_player(id: int, position: Vector2):
	print("Spawning player",id)
	var player = player_scene.instantiate()
	player.player_id = id
	player.position = position
	Utils.get_entities_layer().add_child(player)	
	player.player_ready.connect(_on_player_ready)
	player.player_exited_screen.connect(_on_player_exited_screen)
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("p2_join"):
		print("p2_join")
		add_second_player()
		
func add_second_player():
	if Utils.get_player_count() < 2:
		spawn_player(2, get_spawn_position())

func get_spawn_position() -> Vector2:
	var player = Utils.get_player()
	var viewport_width = get_viewport().get_visible_rect().size.x
	var offset_x = viewport_width * 0.1  # 10% of screen width
	
	if player == null:
		return Vector2.ZERO
		
	var spawn_position = player.position + Vector2(offset_x, 0)
			
	return spawn_position
		
func _on_player_ready(player):
	current_player_count += 1
	player.health_component.died.connect(on_player_died)
	
func _on_player_exited_screen(player):
	move_player_to_fisrt_player(player)
	
func move_player_to_fisrt_player(player):
	var spawn_position = get_spawn_position()
	player.position = get_spawn_position()
	
func on_player_died():
	current_player_count -= 1
	if current_player_count <= 0:
		GameEvents.emit_no_players_left()
