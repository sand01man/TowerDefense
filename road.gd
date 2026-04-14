class_name Roads extends TileMapLayer


var astar_2d := AStar2D.new()
var road_tiles := get_used_cells()

var map_size = get_used_rect().size


func _prepare_pathfinding_graph() -> void:
	for current_cell: Vector2i in road_tiles:
		pass
		#var current_cell_index =  _calculate_index(current_cell)
		#astar_2d.add_pointZ(current_cell_index, current_cell)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
