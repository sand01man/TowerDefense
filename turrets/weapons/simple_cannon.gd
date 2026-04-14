class_name SimpleCannon extends Weapon
@onready var spawn_point: Node2D = %SpawnPoint

func _physics_process(delta: float) -> void:
	var mobs_in_range := _area_2d.get_overlapping_areas()
	if not mobs_in_range.is_empty():
		var target: Area2D = mobs_in_range.front()
		look_at(target.global_position)
# code to test if simple cannon works
	#if mob != null:
		#mob.global_position = get_global_mouse_position()

func _attack() -> void:
	var mobs_in_range := _area_2d.get_overlapping_areas()
	if mobs_in_range.is_empty():
		return
	
	var rocket: Node2D = preload("res://simple_rocket.tscn").instantiate()
	get_tree().current_scene.add_child(rocket)
	rocket.global_transform = spawn_point.global_transform
