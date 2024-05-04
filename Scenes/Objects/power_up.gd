extends Area2D

@export var can_destroy : bool = true
@onready var sprite_2d = $Sprite2D

@export var power_up : Dictionary ={
	"shield" : true,
	"gas" : false,
	#"armo" : false,
	"life" : false
}

var gas_amount := 20
var life_amount := 2
var icons : Dictionary = {
	"shield" : preload("res://essets/kenney_space-shooter-redux/PNG/Power-ups/powerupBlue_shield.png"),
	"gas" : preload("res://essets/kenney_space-shooter-redux/PNG/Power-ups/powerupBlue_bolt.png"),
	#"armo" : preload("res://essets/kenney_space-shooter-redux/PNG/Power-ups/powerupBlue_star.png"),
	"life" : preload("res://essets/kenney_space-shooter-redux/PNG/Power-ups/pill_blue.png")
}
var the_power_up

func _ready():
	sprite_2d.texture = null
	print_debug("---------------------------")
	for i in power_up:
		if power_up[i]:
			the_power_up = i
			sprite_2d.texture = icons[i]


func self_destroy():
	if self_destroy:
			self.queue_free()
