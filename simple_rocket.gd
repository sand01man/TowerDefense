class_name Rocket extends Area2D


var distance : float = 0
@export var speed := 350.0
@export var max_distance := 1000.0
var starting_position = 0
var current_position = 0


func _ready() -> void: 
	starting_position = global_position
	

func _physics_process(delta: float) -> void:
	current_position = position
	position += transform.x * speed * delta
	var distance_traveled = (starting_position - current_position ).length()
	if distance_traveled >= 500: 
			explode()
			
			
func explode() -> void:
	queue_free()

func _init() -> void:
	monitorable = false
	
