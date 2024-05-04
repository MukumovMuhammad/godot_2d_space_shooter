extends Node2D

var laser := preload("res://Scenes/Common/laser.tscn")

var player_group : bool = false
@onready var audio = $AudioStreamPlayer2D

func _ready():
	if get_parent().is_in_group("Player"):
		player_group = true


func shoot(shoot_lvl : int):
	if audio:
		audio.play()
	self.rotation = get_parent().rotation
	var Lassers : Array
	var first_shot : bool = false
	var posX : int = 0
	var posY : int = 0
	for i in range(shoot_lvl):
		var l = laser.instantiate()
		l.Player_shot = player_group
		l.global_rotation_degrees = get_parent().global_rotation_degrees + 90;
		if shoot_lvl % 2 == 1 and !first_shot:
			first_shot = true
			posX = 0
		elif !first_shot:
			first_shot = true
			posX = 10
		l.global_position = self.global_position + Vector2(posY,posX).rotated(rotation)
		if sign(posX) == -1:
			posX *= -1
			posX += 20
			posY -= 10
		elif sign(posX) == 1:
			posX *= -1
		else:
			posX += 20
			posY -= 10
			
		Lassers.append(l)
	for i in Lassers:
		get_parent().get_parent().add_child(i)
