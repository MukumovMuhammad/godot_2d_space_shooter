extends Node
@onready var comet_spawner = $comet_spawner

@onready var enemy_spawn_timer = $enemy_spawn_timer



@export_category("Nodes")
@export var enemies : Node2D
@export var meteords : Node2D
@export_category("UI and Player")
@export var Player : ship
@export var pause : Control
@export var camera : Camera2D

var data := load("res://data/data.tres")
var can_spawn : bool = true
var camera_pos : Vector2
func _ready():
	print_debug("the data ======" , data.mode)
	if data.mode == 0:
		enemy_spawn_timer.start()
	comet_spawner.start()
		


func _process(delta):
	if Player == null:
		can_spawn = false
		var cam : Camera2D = Camera2D.new()
		cam.global_position = camera_pos
		get_parent().add_child(cam)
		pause.player_dead()
	else:
		camera_pos = camera.global_position

func spawn_simple_enemy():
	var _enemy := preload("res://Scenes/enemy/simple_enemy.tscn").instantiate()
	var offset_vec := Vector2(200,200)
	var _i = randi_range(1,10)


	if _i > 1 and _i < 3:
		offset_vec = Vector2(500,0)
	elif _i > 3 and _i < 6:
		offset_vec = Vector2(-500,500)
	elif _i > 6 and _i < 9:
		offset_vec = Vector2(500,-500)
	else:
		offset_vec = Vector2(-500,-500)
	
	_enemy.global_position = Player.global_position + offset_vec
	enemies.add_child(_enemy)
	enemy_spawn_timer.start()


func comet_spawn():
	var comet := preload("res://Scenes/Objects/comet.tscn").instantiate()
	var comet_offset := Vector2(200,200)
	var _i = randi_range(1,10)


	if _i > 1 and _i < 3:
		comet_offset = Vector2(-700,700)
	elif _i > 3 and _i < 6:
		comet_offset = Vector2(700,0)
	elif _i > 6 and _i < 9:
		comet_offset = Vector2(-700,-700)
	else:
		comet_offset = Vector2(700,0)
	
	
	comet.global_position = Player.global_position + comet_offset
	comet.look_at(Player.global_position)
	comet.the_comet = true
	meteords.add_child(comet)
	comet_spawner.start()

func _on_enemy_spawn_timer_timeout():
	if can_spawn:
		spawn_simple_enemy()




func _on_comet_spawner_timeout():
	if can_spawn:
		comet_spawn()
