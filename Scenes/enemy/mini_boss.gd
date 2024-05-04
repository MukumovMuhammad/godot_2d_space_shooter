extends ship
var add_life : int = 0
@onready var max_given_distance := 500
@onready var tele_distance := 500.0
@onready var can_teleport : bool = false
@onready var teleporting : bool = false
@export var Player : CharacterBody2D
@onready var teleport_timer = $teleport_timer
@onready var anim = $AnimatedSprite2D
@onready var apearing_timer = $apearing_timer
@onready var hit_area = $hit_area
@onready var shooter_muzzle_2 = $shooter_muzzle2
var move_where := 1
func _ready():
	teleport_timer.wait_time = randf_range(0.5, 3.0)
	teleport_timer.start()
	anim.play("1")
	speed = 50.0
	max_life = 35
	class_ready()
	max_life += add_life



func _physics_process(delta):
	if Player != null:
		look_at(Player.global_position);
		if get_distnance(Player.global_position, self.global_position) > max_given_distance:
			move_to_forward(1)
		else:
			move_to_sides(move_where)
		if !teleporting:
			shoot()
		move_and_slide()





func get_distnance(pos1 : Vector2, pos2 : Vector2):
	var _dis = sqrt(pow(pos2.x - pos1.x,2) + pow(pos2.y - pos1.y,2))
	return _dis


func teleport_distance(pos1 : Vector2, pos2 : Vector2): 
	# POS1 -> From player distance 
	# POS2 -> an Object distance
	# a distance
	var _dis = sqrt(pow(pos2.x - pos1.x,2) + pow(pos2.y - pos1.y,2))
	var pos := pos2
	
	pos.x = pos1.x + (tele_distance * (pos2.x - pos1.x))/_dis
	pos.y = pos1.y + (tele_distance * (pos2.y - pos1.y))/_dis
	
	return pos


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



	
	
	
func shoot():
	if can_shoot and components:
		can_shoot = false
		Shooter_Muzzle.shoot(shoot_level)
		shooter_muzzle_2.shoot(shoot_level)
		components.shoot_cooldown.start()

func _on_animated_sprite_2d_animation_finished():
	print_debug(" ------------- The animation name is ------------- : " , anim.name)
	if anim.animation == "disappearing":
		self.hide()
		apearing_timer.start()
	elif anim.animation == "appearing":
		teleporting = false
		self.set_collision_mask_value(2,true)
		self.set_collision_layer_value(2,true)
		hit_area.monitoring = true
		components.show_life_bar = true
		teleporting = false 
		anim.play("1")
		teleport_timer.wait_time = randf_range(0.5, 3.0)
		teleport_timer.start()


func _on_apearing_timer_timeout():
	move_where = sign(randi_range(-1,1))
	if Player == null:
		return
	var offset_pos : Vector2 = random_distance_of(randi_range(200,500))
	self.global_position = Player.global_position + offset_pos
	self.show()
	anim.play("appearing")


func _on_teleport_timer_timeout():
	teleporting = true
	components.show_life_bar = false
	self.set_collision_mask_value(2,false)
	self.set_collision_layer_value(2,false)
	
	anim.play("disappearing")



func Death(player_shot : bool):
	if player_shot and game_manager:
		game_manager.Player_killed(score, get_groups())
	var parts := preload("res://Scenes/Common/auto_laser_hooter.tscn").instantiate()
	parts.position = position
	parts.set_collision_mask_value(3,true)
	parts.auto_destroy = true
	get_parent().get_parent().get_node("turels").add_child(parts)
	self.queue_free()
