extends CharacterBody2D

var player = null

var dash_speed = 800.0 
var dash_direction = Vector2.ZERO

@onready var anim = $AnimatedSprite2D

var is_dashing = false
var dash_timer = 0.0
var wait_timer = 1.0

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if not player: return
	
	if not is_dashing:
		velocity = Vector2.ZERO
		wait_timer -= delta
		
		var dir_to_player = global_position.direction_to(player.global_position)
		if dir_to_player.x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
			
		anim.play("idle")
		
		if wait_timer <= 0:
			is_dashing = true
			dash_timer = 0.3 
			dash_direction = dir_to_player
	else:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		
		if velocity.x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
			
		anim.play("run")
		
		if dash_timer <= 0:
			is_dashing = false
			wait_timer = 1.5 

	move_and_slide()
