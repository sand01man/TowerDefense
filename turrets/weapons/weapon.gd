@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

var _area_2d := _create_area_2d()
@onready var _collision_shape_2d := _create_collision_shape_2d()
@export var mob_detection_range := 400.0
@export var attack_rate :=1.0
@onready var _timer := _create_timer()
func _create_area_2d() -> Area2D:
	var area := Area2D.new()
	area.monitoring = true 
	area.monitorable = false
	return area
func _create_collision_shape_2d() -> CollisionShape2D:
	var collision_shape := CollisionShape2D.new() 
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = mob_detection_range
	return collision_shape
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("adding turret nodes")
	add_child(_area_2d) # Replace with function body.
	_area_2d.add_child(_collision_shape_2d)
# Called every frame. 'delta' is the elapsed time since the previous frame.
	_timer.timeout.connect(_attack)
	add_child(_timer)
	_timer.start()

func _create_timer() -> Timer:
	var timer := Timer.new()
	timer.wait_time = 1.0/ attack_rate
	return timer
	
func _attack() -> void:
	return
