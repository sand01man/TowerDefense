class_name Mob extends Area2D

@export var health := 100:
	set = set_health
var tween: Tween = null
var tweens_running := 0
@onready var _health_bar: ProgressBar = %HealthBar
 

func set_health(new_health: int) -> void:
	health = maxi(0, new_health)

	if _health_bar != null:
		
		if tweens_running > 0: 
			tween.kill()
			tweens_running -= 1
			tween = create_tween()
			tween.tween_property(_health_bar, "value", new_health, 1.0)
			tweens_running += 1
		else:
			tween = create_tween()
			tween.tween_property(_health_bar, "value", new_health, 1.0)
			tweens_running += 1

	if health <= 0:
		_die()

func take_damage(damage) -> void:
	health -= damage
	
func _die() -> void:
	queue_free()
