class_name MobSpawner extends Node2D
var _path := Path2D.new()
@onready var road: Roads = %Road
var mob_packed_scene = preload("res://mobs/mob.tscn")
@onready var timer: Timer = %Timer
@onready var winscreen: Control = %Winscreen
@export var mob_spawn_interval := 2.0
@export var wave_amount : float = 10.0
@export var wave_interval := 30.0
var mobs_this_wave := 2
var waves_begun = 0
func _ready() -> void:
	timer.timeout.connect(spawn_mob)
	timer.timeout.connect(mob_amount_counter)
	timer.wait_time = wave_interval
	spawn_mob()
	waves_begun += 1
	timer.start()
	_path.top_level = true
	add_child(_path)
	_path.curve = Curve2D.new()
	
	
	
func initialize_path(points: PackedVector2Array) -> void:
	_path.curve.clear_points()
	for point in points:
		_path.curve.add_point(point)
	
func spawn_mob() -> void:
	if waves_begun <= wave_amount:
		for i in mobs_this_wave + (waves_begun * 2):
			 
			
			await get_tree().create_timer(mob_spawn_interval).timeout
		
			var mob_path_follow := MobPathFollow.new()
			_path.add_child(mob_path_follow)
		
		
			var mob : Mob = mob_packed_scene.instantiate()
			mob_path_follow.add_child(mob)
			mob_path_follow.mob = mob
	if _path.get_child_count() <= 0:
		print(_path.get_child_count())
		winscreen.visible = true
			 
func mob_amount_counter() -> void:
	waves_begun += 1
	

# Called when the node enters the scene tree for the first time.
