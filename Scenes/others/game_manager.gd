extends Node
@onready var comet_spawner = $comet_spawner

@onready var enemy_spawn_timer = $enemy_spawn_timer
#preload("res://Scenes/enemy/simple_enemy.tscn")
@export var enemies : Node2D
@export var meteords : Node2D
@export var Player : ship

func _ready():
	enemy_spawn_timer.start()
	comet_spawner.start()

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
	spawn_simple_enemy()



func _on_comet_spawner_timeout():
	comet_spawn()
