extends Area2D
@onready var lasers_sprite : AnimatedSprite2D = $lasers_sprite
@export var speed : float = 800.0
var hit_demage = 1
var comet_demage = 2
var movement_vector : Vector2 = Vector2(0,-1)
var hitted : bool = false
var the_comet : bool = false
@onready var collision_shape_2d = $CollisionShape2D
var Player_shot : bool = false
func _ready():
	pass
	#print_debug("Laser is created")
	#preload("res://essets/kenney_space-shooter-redux/Bonus/sfx_laser1.ogg")
	
 
func _physics_process(delta):
	if !hitted:
		if the_comet:
			global_position += movement_vector.rotated(rotation+1.8) * speed * delta
		else:
			global_position += movement_vector.rotated(rotation) * speed * delta
	else:
		collision_shape_2d.disabled = true


func Destroy():
	self.queue_free()
	

#lasers_sprite.play("blue_destroy")


func _on_visible_on_screen_notifier_2d_screen_exited():
	Destroy()


func _on_body_entered(body):
	if body.is_in_group("ship"):
		hitted = true
		lasers_sprite.play("blue_destroy") 



func _on_lasers_sprite_animation_finished():
	if lasers_sprite.animation == "blue_destroy":
		Destroy()
