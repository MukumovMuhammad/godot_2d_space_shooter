extends Area2D

@onready var shooter_muzzle = $gun/shooter_muzzle
var auto_destroy : bool = false
var fire : bool = false
@export var shoot_for_player : bool = false
func _ready():
	if auto_destroy:
		$destroy_timer.start()

func _physics_process(delta):
	var over_lapps_bodies = get_overlapping_bodies()
	if over_lapps_bodies.size() > 0:
		fire = true
		var target = over_lapps_bodies.front()
		$gun.look_at(target.global_position)
	else:
		fire = false


func _on_timer_timeout():
	if fire:
		shooter_muzzle.shoot(1)
		shooter_muzzle.player_group = shoot_for_player


func _on_destroy_timer_timeout():
	self.queue_free()
