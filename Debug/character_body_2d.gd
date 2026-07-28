extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0


@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = sign(velocity.x) == -1
		if(is_on_floor()):
			$AnimationPlayer.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("jump")
	
	
	move_and_slide()


var flip = false

func _on_after_image_2d_frame_spawned(frame: Sprite2D) -> void:
	
	flip = !flip
	
	if(flip):
		$AfterImage2D.modulate = Color(1.0, 0.0, 0.0, 1.0)
	else:
		$AfterImage2D.modulate = Color(0.0, 1.0, 0.388, 1.0)
	
	#$AfterImage2D.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))
