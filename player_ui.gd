extends Control
@onready var h_box_container: HBoxContainer = %HBoxContainer

signal health_depleted

var health := 6: set = set_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	print("heyo")
	
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
	for current_heart in health_sprites_list:
			current_heart.visible = health > current_heart.get_index()
	if health == 0:
		health_depleted.emit()
