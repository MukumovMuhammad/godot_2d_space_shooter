extends Control
@onready var h_box_container = $CanvasLayer/HBoxContainer
var max_distance := 600
var in_show_dis := 300
@export var Enemies : Node
var heart_ship = preload("res://Scenes/UI/life_ship.tscn")
@onready var progress_bar = $CanvasLayer/ProgressBar
var enemy = preload("res://Scenes/UI/enemy_icon.tscn")
@export var Player : CharacterBody2D
var All_enemies : Array
func _ready():
	#set_max_heart(3)
	for i in Enemies.get_children():
		var en = enemy.instantiate()
		All_enemies.append(en)
		add_child(en)
	
	
	for i in All_enemies:
		i.hide()


func _process(delta):
	var i = 0
	
	for _i in Enemies.get_children():
		if !_i:
			All_enemies[i].hide()
		#print_debug("So it is the ----------" , i)
		if get_distnance(Player.global_position, _i.global_position) > max_distance:
			All_enemies[i].global_position = teleport_distance(Player.global_position , _i.global_position)
			All_enemies[i].show()
		else:
			All_enemies[i].hide()
			
		
		i += 1
		if i > 4:
			i = 0
	i = 0

func set_max_heart(_max : int):
	print_debug("setting max heart")
	var hearts = h_box_container.get_children()
	for i in hearts:
		i.free()
		
	for i in range(_max):
		var heart = heart_ship.instantiate()
		h_box_container.add_child(heart)


func _on_player_lifes_left(lifes):
	set_max_heart(lifes)


func _on_player_turbo_left(gas):
	progress_bar.value = gas



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
