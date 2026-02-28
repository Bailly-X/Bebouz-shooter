extends Area2D

var speed = 600.0
var direction = Vector2.ZERO

var blood_scene = preload("res://scene/blood_particles.tscn")

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):	
	if body.is_in_group("enemy"):
		get_tree().current_scene.add_score(1)
		if blood_scene:
			var blood = blood_scene.instantiate()
			blood.global_position = body.global_position
			blood.rotation = direction.angle()
			get_tree().current_scene.call_deferred("add_child", blood)
		body.queue_free()
		queue_free()
