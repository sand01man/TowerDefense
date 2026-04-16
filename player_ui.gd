extends Control
@onready var h_box_container: HBoxContainer = %HBoxContainer
@onready var coin_icon_2: TextureRect = %CoinIcon
@onready var _coin_label: Label = %CoinLabel
@onready var marker_2d: Marker2D = $HBoxContainer/CoinIcon/Marker2D

signal health_depleted

var health := 6: set = set_health
var coins := 0  : set = set_coins

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerUI.health_depleted.connect(
		func() -> void:
			get_tree().reload_current_scene.call_deferred()
			
			PlayerUI.health = 6
			for i in h_box_container.get_children():
				i.visible = true
				
	)

func get_coin_ui_position() -> Vector2:
	var coin_destination = marker_2d.global_position
	return coin_destination
	

func set_health(new_health) -> void: 
	
	health = clampi(new_health, 0, 6)
	var health_sprites_list : Array = h_box_container.get_children()
	#print(health_sprites_list[0].get_index())
	for current_heart in health_sprites_list:
			current_heart.visible = health > current_heart.get_index()
	if health == 0:
		health_depleted.emit()
func set_coins(new_coins : int) -> void:
	coins = maxi(0, new_coins)
	if _coin_label != null:
		_coin_label.text = str(coins)
