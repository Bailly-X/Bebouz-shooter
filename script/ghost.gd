extends CharacterBody2D

var speed = 120.0
var player = null

var time_passed = 0.0
var zigzag_amplitude = 300.0
var zigzag_frequency = 5.0

@onready var anim = $AnimatedSprite2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	time_passed = randf() * TAU 

func _physics_process(delta):
	if player:
		time_passed += delta
		
		var forward_dir = global_position.direction_to(player.global_position)
		var side_dir = forward_dir.rotated(PI / 2.0)
		var wave_movement = side_dir * sin(time_passed * zigzag_frequency) * zigzag_amplitude
		
		velocity = (forward_dir * speed) + wave_movement
		
		if velocity.x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
			
		anim.play("run")
		
		move_and_slide()
