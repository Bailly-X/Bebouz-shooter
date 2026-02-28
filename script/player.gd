extends CharacterBody2D

const SPEED = 300.0
@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D 
@onready var flash_light = $FlashLight
var fire_rate = 0.7#0.15
var fire_timer = 0.0
var is_multi_shot = false
var multi_shot_timer = 0.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")

	flash_light.look_at(get_global_mouse_position())

	if get_global_mouse_position().x < global_position.x:
		anim.flip_h = true
	else:
		anim.flip_h = false
		
	if direction:
		velocity = direction * SPEED
		anim.play("run")
	else:
		velocity = Vector2.ZERO
		anim.play("idle")
		
	move_and_slide()

	if fire_timer > 0:
		fire_timer -= delta
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and fire_timer <= 0:
		shoot()
		fire_timer = fire_rate

	if multi_shot_timer > 0:
		multi_shot_timer -= delta
		if multi_shot_timer <= 0:
			is_multi_shot = false

func upgrade_fire_rate():
	fire_rate -= 0.15

	if fire_rate < 0.1:
		fire_rate = 0.1 

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemy"):
		print("GAME OVER !")
		get_tree().call_deferred("change_scene_to_file", "res://scene/game_over.tscn")

func activate_multi_shot():
	is_multi_shot = true
	multi_shot_timer = 5.0

func shoot():
	if not bullet_scene: return 
	var base_direction = global_position.direction_to(get_global_mouse_position())
	
	if is_multi_shot:
		var angles = [-0.25, 0.0, 0.25] 
		
		for angle_offset in angles:
			var b = bullet_scene.instantiate()
			b.global_position = global_position
			b.direction = base_direction.rotated(angle_offset)
			get_tree().current_scene.add_child(b)
	else:
		var b = bullet_scene.instantiate()
		b.global_position = global_position
		b.direction = base_direction
		get_tree().current_scene.add_child(b)
