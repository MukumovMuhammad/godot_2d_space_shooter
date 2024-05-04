extends ship

var spawner : Node
var Player : CharacterBody2D
var bounce_back : bool = false
@onready var muzzle := $muzzle
@onready var bounce_timer := $bounce_timer

var can_move : bool = true
func _ready():
	class_ready()
	


func _physics_process(delta):
	if Player != null and can_move:
		look_at(Player.global_position)
		
		if !bounce_back:
			move_to_forward(1)
		else:
			move_to_forward(-1)
		move_and_slide()
		

func Death(player_shot : bool):
	if player_shot:
		game_manager.Player_killed(score, get_groups())
	if Player != null:
		spawner.hydra_spawn(self.global_position)
		spawner.hydra_spawn(self.global_position)
		var parts := preload("res://Scenes/others/after_death_part.tscn").instantiate()
		#parts.is_hydra = true
		parts.global_position = self.global_position
		self.queue_free()
		#parts.position = position
	
		get_parent().get_parent().get_node("power_ups").add_child(parts)
func demage_anim():
	pass


func _on_muzzle_bounce_back():
	bounce_timer.start()
	bounce_back = true


func _on_bounce_timer_timeout():
	bounce_back = false


func _on_visible_on_screen_notifier_2d_screen_entered():
	can_move = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	can_move = false
