extends Control
@onready var h_box_container = $CanvasLayer/HBoxContainer


var heart_ship = preload("res://Scenes/life_ship.tscn")

func _ready():
	#set_max_heart(3)
	pass

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
