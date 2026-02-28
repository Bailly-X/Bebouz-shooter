extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player") and body.has_method("activate_multi_shot"):
		body.activate_multi_shot()
		call_deferred("queue_free")
