extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

var speed = 100.0
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		
		if velocity.x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
			
		anim.play("run")
		
		move_and_slide()
