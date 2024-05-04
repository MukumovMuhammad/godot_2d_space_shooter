extends Node

@onready var game_timer = $game_timer

@export var in_show_dis := 420 
@export_category("Configs")
@export var spawn_enemise : bool = true
@export_category("UI and Player")
@export var Player : ship
@export var Player_HUD : Control
@export var pause : Control
@export var camera : Camera2D

var score_text : String
var data := load("res://data/data.tres")
var camera_pos : Vector2
var The_game_timer : int = 0
var Player_score : int = 0
var count := false
var Player_improver_count : int = 10
var Laser_too_count : int = 100
var player_can_upgrade := false

@export var spawner : Node
func _ready():
	#spawners
	spawner.can_spawn = true
	spawner.Player = Player
	spawner.game_manager = self
	Player.game_manager = self
	if spawn_enemise:
		spawner.start_spawning(data.mode)
		
	
	#HUD
	game_timer.start()
	Player_HUD.game_manager = self
	Player_HUD.timer.text = "Time: " + str(The_game_timer)
	Player_HUD.score.text = "score: " + str(Player_score)
	
	


			
			



func Player_killed(score : int, enemy_type : Array):
	if "mini_boss" in enemy_type and !spawner.can_spawn:
		spawner.start_spawning(data.mode)

	Player_score += score
	if Player_score > Player_improver_count:
		spawner.add_points += 2
		Player_improver_count += Player_improver_count
		if Player_improver_count > Laser_too_count:
			spawner.remove_all_enemies()
			spawner.mini_bos_spawn()
			Laser_too_count += Laser_too_count
			spawner.add_points += spawner.add_points
			Player_HUD.upgrade_player(true)
		else:
			Player_HUD.upgrade_player(false)
		get_tree().paused = true
		
		
	Player_HUD.score.text = "score: " + str(Player_score) 



func Player_died():
	spawner.can_spawn = false
	var cam : Camera2D = Camera2D.new()
	cam.global_position = camera_pos
	get_parent().add_child(cam)
	save_progress()
	pause.player_dead()
	pause.show_score(score_text)
	Player.queue_free()



func Player_upgrade_choise(ability: String):
	get_tree().paused = false
	Player.upgrade(ability)
	

func save_progress():
	if The_game_timer > data.best_timer:
		data.best_timer = The_game_timer
		ResourceSaver.save(data, "res://data/data.tres")
	if Player_score > data.score:
		data.score = Player_score
		ResourceSaver.save(data, "res://data/data.tres")
	score_text = "Your score : " + str(Player_score) + "\nThe best score : " + str(data.score) 



func _on_game_timer_timeout():
	The_game_timer += 1
	Player_HUD.timer.text = "Time: " + str(The_game_timer)
	game_timer.start()


