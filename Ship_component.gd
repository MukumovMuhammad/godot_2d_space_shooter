extends CharacterBody2D
class_name ship

@export var timers : Node2D




var rotation_speed : float = 10.0
var speed = 400.0
var turbo_speed = speed * 2
var max_life : int = 3
var current_life : int
var max_turbo : int = 10
var turbo : int
var have_shield : bool = false
var take_turbo_gas : bool = false
var can_shoot : bool = true
func _ready():
	current_life = max_life
	turbo = max_turbo



func move_to(where : int):
	velocity = transform.x * sign(where) * speed 

func ship_rotate(where : int):
	var rotate_player = sign(where) / rotation_speed
	rotate(rotate_player)


func turbo_move():
	if turbo > 0:
		velocity = transform.x * turbo_speed
	if !take_turbo_gas:
		take_turbo_gas = true
		timers.turbo_take_timer.start()

func take_demage(points : int):
	if !have_shield:
		current_life -= points
	if current_life < 0:
		Death()


func Death():
	self.queue_free()

func get_life(points : int):
	current_life += points
	if current_life > max_life:
		current_life = max_life

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
