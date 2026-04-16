extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(func(area) -> void:
		if area is Coin:
			print("hi coin")
			area.animate_to_ui())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
