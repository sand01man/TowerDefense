class_name Mob extends Area2D
@onready var sprite_2d: Sprite2D = %Sprite2D

@onready var _bar_pivot: Node2D = %BarPivot
var alive: bool = true
static var call_count = 0

@export var speed := 100.0
@export var health := 100:
	set = set_health
var tween: Tween = null
var tweens_running := 0
@onready var _health_bar: ProgressBar = %HealthBar
@export var coins := 1

func set_health(new_health: int) -> void:
	health = maxi(0, new_health)

	if _health_bar != null:
		
		if tweens_running > 0: 
			tween.kill()
			tweens_running -= 1 
			tween = create_tween()
			tween.tween_property(_health_bar, "value", new_health, 0.2)
			tweens_running += 1
		else:
			tween = create_tween()
			tween.tween_property(_health_bar, "value", new_health, 0.2)
			tweens_running += 1

	if health <= 0:
		if alive == true:
			_die(true)
		alive = false
		alive = false
		alive = false
		alive = false

func take_damage(damage) -> void:
	health -= damage
	
func _die(was_killed) -> void:
	alive = false
	call_count += 1
	print("i was called " + str(call_count))
	if was_killed: 
		for current_index: int in coins:
			var coin: Node2D = preload("coin.tscn").instantiate()
			get_tree().current_scene.add_child.call_deferred(coin)
			coin.global_position = global_position
	queue_free()
	
func _physics_process(delta: float) -> void:
	_bar_pivot.global_rotation = 0.0
