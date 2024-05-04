extends Control
@onready var h_box_container = $CanvasLayer/Lifes/HBoxContainer
var max_distance := 820
var in_show_dis := 420
@export var Enemies : Node2D
var heart_ship = preload("res://Scenes/UI/life_ship.tscn")
@onready var progress_bar = $CanvasLayer/ProgressBar
var enemy = preload("res://Scenes/UI/enemy_icon.tscn")
@export var Player : CharacterBody2D
var All_enemies : Array
@onready var timer = $CanvasLayer/timer
@onready var score = $CanvasLayer/score
@onready var abilites = $CanvasLayer/abilites
@onready var game_manager : Node
@onready var shield_progress_bar = $CanvasLayer/shield_progress_bar
var upgrade_count : int
@onready var super_abilities = $CanvasLayer/Super_abilities

func _ready():
	abilites.hide()
	super_abilities.hide()
	shield_progress_bar.hide()
	"""
	#set_max_heart(3)
	for i in Enemies.get_children():
		var en = enemy.instantiate()
		All_enemies.append(en)
		add_child(en)
	
	
	for i in All_enemies:
		i.hide()
"""


func set_max_heart(_max : int):
	print_debug("setting max heart")
	var hearts = h_box_container.get_children()
	for i in hearts:
		i.free()
		
	for i in range(_max):
		var heart = heart_ship.instantiate()
		
		
		h_box_container.add_child(heart)
	$CanvasLayer/Lifes/label.text = "Life : " + str(_max)


func _on_player_lifes_left(lifes):
	set_max_heart(lifes)


func _on_player_turbo_left(gas):
	progress_bar.value = gas

func upgrade_player(laser_too : bool):
	if laser_too:
		abilites.hide()
		super_abilities.show()
	else:
		abilites.show()
		super_abilities.hide()


func teleport_distance(pos1 : Vector2, pos2 : Vector2): 
	# a distance
	var _dis = sqrt(pow(pos2.x - pos1.x,2) + pow(pos2.y - pos1.y,2))
	var pos := pos2

	pos.x = pos1.x + (in_show_dis * (pos2.x - pos1.x))/_dis
	pos.y = pos1.y + (in_show_dis * (pos2.y - pos1.y))/_dis
	
	return pos

func get_distnance(pos1 : Vector2, pos2 : Vector2):
	var _dis = sqrt(pow(pos2.x - pos1.x,2) + pow(pos2.y - pos1.y,2))
	return _dis


func _on_player_shield_time_left(max, left):
	if left == 0:
		shield_progress_bar.hide()
	else:
		shield_progress_bar.show()
	shield_progress_bar.max_value = max
	shield_progress_bar.value = left
	$CanvasLayer/shield_progress_bar/Label.text = str(snapped(left, 0.1))




func _on_speed_pressed():
	game_manager.Player_upgrade_choise("speed")
	abilites.hide()
	super_abilities.hide()


func _on_faster_shoot_pressed():
	game_manager.Player_upgrade_choise("faster_shoot")
	abilites.hide()
	super_abilities.hide()


func _on_shield_time_pressed():
	game_manager.Player_upgrade_choise("shield_time")
	abilites.hide()
	super_abilities.hide()



func _on_max_life_pressed():
	game_manager.Player_upgrade_choise("max_life")
	abilites.hide()
	super_abilities.hide()


func _on_speed_2_pressed():
	game_manager.Player_upgrade_choise("turbo")
	abilites.hide()
	super_abilities.hide()


func _on_ufo_pressed():
	game_manager.Player_upgrade_choise("ufo_shooter")
	abilites.hide()
	super_abilities.hide()


func _on_laser_pressed():
	game_manager.Player_upgrade_choise("laser")
	abilites.hide()
	super_abilities.hide()
