class_name Roads extends TileMapLayer

@onready var road: Roads = %Road

var astar_2d := AStar2D.new()
var road_tiles := get_used_cells()

var map_size = get_used_rect().size


func _prepare_pathfinding_graph() -> void:
	for current_cell: Vector2i in road_tiles:
		var current_cell_index := _calculate_index(current_cell)
		astar_2d.add_point(current_cell_index, current_cell)

func _calculate_index(cell_coordinates: Vector2i) -> int:
	return cell_coordinates.x + (cell_coordinates.y * map_size.x) + 10_000
# Called when the node enters the scene tree for the first time.
	for current_cell: Vector2i in road_tiles:
		for current_neighbor: Vector2i in [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]:
			var neighbor_position := current_cell + current_neighbor
			if get_cell_source_id(neighbor_position) == -1:
				continue
