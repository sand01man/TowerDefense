extends Node2D
var _game_board : Dictionary[Vector2i, Turret]= {}
@onready var _turret: Turret = %Turret
@onready var _player_hurtbox: Area2D = %PlayerHurtBox
@onready var grass: TileMapLayer = %Grass
@onready var _roads: TileMapLayer = %Road

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(_game_board)
	_player_hurtbox.area_entered.connect(
		func (_other_area: Area2D) -> void:
			PlayerUI.health -= 1
	)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		var cell_coordinates  = grass.local_to_map(get_global_mouse_position())
		var cell_contents := _roads.get_cell_source_id(cell_coordinates)
		var is_road_tile := cell_contents != -1
		
		_place_turret(cell_coordinates)
func _place_turret(creation_position : Vector2i) -> void:
	var turret : Turret = Turret.new()
	var turret_position := grass.map_to_local(creation_position)
	turret.position = turret_position
	_game_board.get_or_add(turret_position, turret)
	print(_game_board)
	#assert(
			#_game_board.has(creation_position) == false
			#,"whyyyyyyyyy"
	#)
	if _game_board.has(creation_position) == false:
		add_child(turret)
