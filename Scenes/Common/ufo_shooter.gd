extends Marker2D


const SPEED = 3
func _physics_process(delta):
	position = get_parent().position
	rotation += SPEED * delta
