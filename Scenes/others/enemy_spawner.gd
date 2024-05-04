extends Node
@onready var comet_spawner = $comet_spawner
@onready var path = $Path2D

@onready var enemy_spawn_timer = $enemy_spawn_timer
@export var in_show_dis := 420 
@onready var game_manager : Node = get_parent()
@export_category("Nodes")
@export var enemies : Node2D
@export var meteords : Node2D
@onready var Player : ship
var can_spawn : bool = true
#for adding to max_life & speed of enemies
@onready var add_points : int = 0
@onready var max_time_wait := 4.0
@onready var min_time_wait := 0.5
@onready var Enemy_laser_level := 1
@onready var mini_boss_count := 0
func start_spawning(mode : int):
	mini_boss_count += 1
	can_spawn = true
	comet_spawner.start()
	if mode == 1:
		spawn_hydra_enemy()
		min_time_wait = 5.0
		max_time_wait = 15
	enemy_spawn_timer.start()


func remove_all_enemies():
	
	can_spawn = false
	enemy_spawn_timer.stop()
	if max_time_wait > 0.5:
		max_time_wait -= 0.5
	for enemy in enemies.get_children():
		if enemy.is_in_group("ship"):
			enemy.take_demage(1000,false)
	Enemy_laser_level += 1
	
	
func spawn_simple_enemy():
	var _enemy := preload("res://Scenes/enemy/simple_enemy.tscn").instantiate()


	_enemy.max_life += add_points
	_enemy.speed += add_points
	_enemy.global_position = random_distance_of_path()
	_enemy.game_manager = game_manager
	_enemy.shoot_level = Enemy_laser_level
	enemies.add_child(_enemy)
	enemy_spawn_timer.start()


func spawn_hydra_enemy():
	var _enemy := preload("res://Scenes/enemy/hydra_enemy.tscn").instantiate()


	_enemy.global_position = random_distance_of_path()
	_enemy.Player = Player
	_enemy.max_life = 3
	_enemy.speed = 100
	_enemy.spawner = self
	_enemy.game_manager = game_manager
	enemies.add_child(_enemy)

func mini_bos_spawn():
	for i in mini_boss_count:
		var _enemy = preload("res://Scenes/enemy/mini_boss.tscn").instantiate()
	
		_enemy.Player = Player
		_enemy.global_position = random_distance_of_path()
		_enemy.game_manager = game_manager
		_enemy.shoot_level = Enemy_laser_level
		enemies.add_child(_enemy)

func hydra_spawn(pos : Vector2):
	if !can_spawn:
		return
	var _enemy := preload("res://Scenes/enemy/hydra_enemy.tscn").instantiate()
	_enemy.global_position = random_distance_of_path()
	_enemy.max_life += 2
	_enemy.speed += 0.3
	_enemy.Player = Player
	_enemy.spawner = self
	_enemy.game_manager = game_manager
	
	enemies.add_child(_enemy)
	

func comet_spawn():
	var comet := preload("res://Scenes/Objects/comet.tscn").instantiate()
	
	
	comet.global_position = random_distance_of_path()
	comet.look_at(Player.global_position)
	comet.the_comet = true
	meteords.add_child(comet)
	comet_spawner.start()


func random_distance_of_path():
	path.global_position = Player.global_position + Vector2(-850, -500)
	var fallower = path.get_child(0)
	fallower.progress_ratio = randf()
	return fallower.global_position

func random_distance_of(dis : int):
	var _i = randi_range(1,10)
	if _i > 1 and _i < 2:
		return Vector2(dis,0)
	elif _i > 2 and _i < 4:
		return Vector2(-dis,dis)
	elif _i > 4 and _i < 6:
		return Vector2(dis,-dis)
	elif _i > 6 and _i < 8:
		return Vector2(0,-dis)
	else:
		return Vector2(0,dis)


func _on_enemy_spawn_timer_timeout():
	enemy_spawn_timer.wait_time = randf_range(min_time_wait, max_time_wait)
	if can_spawn:
		spawn_simple_enemy()



func _on_comet_spawner_timeout():
	if can_spawn:
		comet_spawn()




""" Later these function must be used for better spawning Enemies with given distances"""
func get_distnance(pos1 : Vector2, pos2 : Vector2):
	var _dis = sqrt(pow(pos2.x - pos1.x,2) + pow(pos2.y - pos1.y,2))
	return _dis

func teleport_distance(pos1 : Vector2, pos2 : Vector2): 
	# a distance
	var _dis = sqrt(pow(pos2.x - pos1.x,2) + pow(pos2.y - pos1.y,2))
	var pos := pos2
	
	pos.x = pos1.x + (in_show_dis * (pos2.x - pos1.x))/_dis
	pos.y = pos1.y + (in_show_dis * (pos2.y - pos1.y))/_dis
	
	return pos
