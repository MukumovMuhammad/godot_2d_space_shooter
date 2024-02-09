extends Area2D
@export var Ship : CharacterBody2D



func _on_body_entered(body):
	if body.is_in_group("laser"):
		Ship.take_demage(body.hit_demage)
	if body.is_in_group("health"):
		Ship.get_life(body.life_point)


func _on_area_entered(area):
	if area.is_in_group("shield"):
		Ship.trigger_shield(1)
		print("Shield was triggered")
