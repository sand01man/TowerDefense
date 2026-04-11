extends Control
@onready var h_box_container: HBoxContainer = %HBoxContainer

signal health_depleted

var health := 6: set = set_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	print("heyo")
	var tween = create_tween()
	tween.tween_property(self,"health", 0, 2.0)
	
	PlayerUI.health_depleted.connect(
		func() -> void:
			get_tree().reload_current_scene.call_deferred()
			
			PlayerUI.health = 6
			for i in h_box_container.get_children():
				i.visible = true
	)

# Called every frame. 'delta' is the elapsedn     time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_health(new_health) -> void: 
	
	health = clampi(new_health, 0, 6)
	var health_sprites_list : Array = h_box_container.get_children()
	#print(health_sprites_list[0].get_index())
	health_sprites_list[health - 1].visible = false
	if health == 0:
		health_depleted.emit()
