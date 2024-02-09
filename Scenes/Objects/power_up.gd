extends Area2D

@export var self_destroy : bool = true




func _on_body_entered(body):
	if body.is_in_group("ship"):
		if self_destroy:
			self.queue_free()
