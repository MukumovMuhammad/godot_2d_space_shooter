extends CharacterBody2D
class_name ship
signal took_demage(demage : int)
signal lifes_left(lifes : int)
signal turbo_left(gas : float)

var laser := preload("res://Scenes/Common/laser.tscn")

@export_category("ship characteristic")
@export var rotation_speed : float = 10.0
@export var speed = 400.0
@export var anim_sprites : AnimatedSprite2D #for demage animations
#@export var ship_sprite : AnimatedSprite2D #for ship sprite it self

var timers : Node2D
var turbo_speed = speed * 2
var max_life : int = 3
var current_life : int
var max_turbo : float = 100.0
var turbo : float
var have_shield : bool = false
var take_turbo_gas : bool = false
var can_shoot : bool = true


func class_ready():
	print_debug("The _ready of class")
	current_life = max_life
	turbo = max_turbo
	lifes_left.emit(max_life)
	if anim_sprites:
		anim_sprites.hide()
	


func move_to_forward(where : int):
	velocity = transform.x * sign(where) * speed 
	#global_position += movement_vector.rotated(rotation) * speed * delta



func move_to_sides(Where : int):
	velocity = transform.y * sign(Where) * speed



func ship_rotate(where : int):
	var rotate_player = sign(where) / rotation_speed
	rotate(rotate_player)


func turbo_move():
	if turbo > -1:
		velocity = transform.x * turbo_speed
		if !take_turbo_gas:
			timers.turbo_take_timer.start()
			turbo_left.emit(turbo)
			take_turbo_gas = true
			print_debug("The timer for turbo activated ")
	else:
		velocity = transform.x * speed 
	
		

func take_demage(points : int):
	
	if !have_shield:
		current_life -= points
		took_demage.emit(points)
		lifes_left.emit(current_life)
		
		if anim_sprites:
			demage_anim()
			
		if current_life < 1:
			Death()

func demage_anim() -> void:
	var _life = protsent(max_life, current_life)
		
	if _life < 90 and _life > 60:
		anim_sprites.show()
		anim_sprites.play("1st_demage")
	elif _life < 70 and _life > 30:
		anim_sprites.show()
		anim_sprites.play("2nd_demage")
	elif _life < 30 and _life > 10:
		anim_sprites.show()
		anim_sprites.play("3rd_demage")
		
func demage_animation() -> void:
	var _life = protsent(max_life, current_life)
	if _life > 80:
		anim_sprites.hide()
	elif _life < 80 and _life > 50:
		anim_sprites.show()
		anim_sprites.play("1st_demage")
	elif _life < 50 and _life > 20:
		anim_sprites.show()
		anim_sprites.play("2nd_demage")
	elif _life < 20 and _life > 5:
		anim_sprites.show()
		anim_sprites.play("3rd_demage")


func Death():
	var parts := preload("res://Scenes/others/after_death_part.tscn").instantiate()
	parts.position = position
	
	get_parent().add_child(parts)
	self.queue_free()
func get_life(points : int):
	current_life += points
	if current_life > max_life:
		current_life = max_life
	demage_animation()


func trigger_shield(type : int):
	print("Shield recieved " , type)
	timers.give_shield(type)
	#timers.shield_sprite.texture = timers.shields[type]
	timers.shield_timer.start()
	have_shield = true

func fill_turbo(points : int):
	turbo += points
	if turbo > max_turbo:
		turbo = max_turbo


func shoot(muzzle):
	if can_shoot and timers:
		can_shoot = false
		var l = laser.instantiate()
		l.rotation = self.rotation + 1.55
		l.global_position = muzzle.global_position
		
		get_parent().add_child(l)
		timers.shoot_cooldown.start()
	

func protsent(_max : int, _current : int):
	return _current * 100/_max
