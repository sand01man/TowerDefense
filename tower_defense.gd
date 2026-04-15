extends Node2D
var _game_board : Dictionary [Vector2i, Turret]= {}

@onready var _player_hurtbox: Area2D = %PlayerHurtBox
@onready var grass: TileMapLayer = %Grass
@onready var _roads: TileMapLayer = %Road

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_hurtbox.area_entered.connect(
		func (_other_area: Area2D) -> void:
			PlayerUI.health -= 1
	)
	for current_child: Node in get_children():
		if current_child is MobSpawner:
			var path = _roads.find_path_to_target(current_child, _player_hurtbox)
			current_child.initialize_path(path)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):
		# mouse_position is set = to the map grid position of its global position
		#basically its set equal to the mouses global position converted into a spot on the grid
		var mouse_position  = grass.local_to_map(get_global_mouse_position())
		var cell_contents := _roads.get_cell_source_id(mouse_position)
		print(mouse_position)
		var is_road_tile := cell_contents != -1
		#check like 34 then come back
		# so then when I check to see if game_board has THAT GRID POSITION
		# it returns true if theres a spot already taken
		if _game_board.has(mouse_position) == false and is_road_tile == false:
			print("there isnt a turret here already")
			_place_turret(mouse_position)
	if event.is_action_pressed("right_mouse_click"):
		var mouse_position  = grass.local_to_map(get_global_mouse_position())
		if _game_board.has(mouse_position):
			print("we have this mouse_position")
			if is_instance_valid(_game_board[mouse_position]):
				_game_board[mouse_position].queue_free()
				_game_board.erase(mouse_position)
				if _game_board.has(mouse_position):
					print("the mouse position wasnt erased")
			else:
				return
func _place_turret(creation_position : Vector2i) -> void:
	#creation_position and mouse_position mean the same thing with the current code
	var turret : Turret = Turret.new()
	print(creation_position)
	print(grass.local_to_map(creation_position))
	turret.position = grass.map_to_local(creation_position)
	print(turret.position)
	print(grass.local_to_map(turret.position))
	#this adds the mouse_positon to the _game_board dictionary, AS A LOCAL POSITION
	_game_board.get_or_add(creation_position, turret)
	add_child(turret)
