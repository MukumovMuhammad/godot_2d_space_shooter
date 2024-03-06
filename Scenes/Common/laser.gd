extends Area2D
@onready var lasers_sprite = $lasers_sprite
@export var speed : float = 800.0
var hit_demage = 1
var comet_demage = 2
var movement_vector : Vector2 = Vector2(0,-1)
var hitted : bool = false
var the_comet : bool = false


func _physics_process(delta):
	if !hitted:
		if the_comet:
			global_position += movement_vector.rotated(rotation+1.8) * speed * delta
		else:
			global_position += movement_vector.rotated(rotation) * speed * delta


func Destroy():
	self.queue_free()
	

#lasers_sprite.play("blue_destroy")


func _on_visible_on_screen_notifier_2d_screen_exited():
	Destroy()


func _on_lasers_sprite_animation_finished():
	if lasers_sprite.animation == "blue_destroy":
		Destroy()


func _on_body_entered(body):
	if body.is_in_group("ship"):
		hitted = true
		lasers_sprite.play("blue_destroy")
