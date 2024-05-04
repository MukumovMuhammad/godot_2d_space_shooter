extends Area2D
@export var Ship : CharacterBody2D
@export var can_get_power_up : bool = true

func _on_body_entered(body):
	if body.is_in_group("health"):
		Ship.get_life(body.life_point)



func _on_area_entered(area):
	if area.is_in_group("power_up") and can_get_power_up:
		Power_up(area)
		
	if area.is_in_group("laser"):
		Ship.take_demage(area.hit_demage, area.Player_shot)
	elif area.is_in_group("comet"):
		Ship.take_demage(area.comet_demage, false)
		#print("Shield was triggered")


func Power_up(power):
	var shield : bool = Ship.have_shield
	var destroy : bool = false
	match power.the_power_up:
			"shield":
				if !shield:
					Ship.trigger_shield(1)
					destroy = true
			"gas":
				Ship.fill_turbo(power.gas_amount)
				destroy = true
			"life":
				if !(Ship.current_life >= Ship.max_life):
					Ship.get_life(power.life_amount)
					destroy = true
	if destroy:
		power.self_destroy()
