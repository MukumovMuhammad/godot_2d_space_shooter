extends Area2D
@export var Ship : CharacterBody2D



func _on_body_entered(body):
	if body.is_in_group("health"):
		Ship.get_life(body.life_point)



func _on_area_entered(area):
	if area.is_in_group("power_up"):
		match area.the_power_up:
			"shield":
				Ship.trigger_shield(1)
			"gas":
				Ship.fill_turbo(area.gas_amount)
			"life":
				Ship.get_life(area.life_amount)
		
		
		area.self_destroy()
	if area.is_in_group("laser"):
		Ship.take_demage(area.hit_demage)
	elif area.is_in_group("shield"):
		Ship.trigger_shield(1)
	elif area.is_in_group("comet"):
		Ship.take_demage(area.comet_demage)
		#print("Shield was triggered")
