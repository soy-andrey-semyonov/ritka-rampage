class_name WeaponContoller
extends Node2D

var weapon: Weapon

@onready var weapon_position: Node2D = $WeaponPosition

func _physics_process(delta):
	
	if Controller.using_controller:
		var vector = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
		rotation = vector.angle()
	else:
		var vector = get_global_mouse_position()
		look_at(vector)

	weapon_position.scale.y = -1 if abs(global_rotation_degrees) >= 90 else 1
	
func shoot():
	if weapon is Weapon:
		weapon.shoot()
		
		
func set_weapon(new_weapon_scene: PackedScene):
	if weapon != null:
		weapon_position.remove_child(weapon)
		return
	
	weapon = new_weapon_scene.instantiate()
	
	if weapon is not Weapon:
		return
	
	weapon.global_rotation = global_rotation
	weapon_position.add_child(weapon)
	
	GameEvents.emit_weapon_changed(weapon)
