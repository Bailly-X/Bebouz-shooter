extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("upgrade_fire_rate"):
			body.upgrade_fire_rate()

		queue_free()
