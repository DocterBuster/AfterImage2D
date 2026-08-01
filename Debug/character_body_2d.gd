extends CharacterBody2D



const JUMP_VELOCITY = -800.0


const SPEED = 50.0
const SLOWDOWN_RATIO = 0.5
const MAX_SPEED = 500.0

@onready var sprite : Sprite2D = $Sprite2D


var calc_velocity : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	calc_velocity = velocity.rotated(-rotation)
	
	# Add the gravity.
	if not is_on_floor():
		calc_velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		calc_velocity.x += direction * SPEED
		calc_velocity.x = clampf(calc_velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = sign(calc_velocity.x) == -1
		if(is_on_floor()):
			$AnimationPlayer.play("walk")
	else:
		calc_velocity.x = move_toward(calc_velocity.x, 0, SPEED * SLOWDOWN_RATIO)
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		calc_velocity.y += JUMP_VELOCITY
		$AnimationPlayer.play("jump")
	
	## Rotate velcoty based on current rotation & add it!
	calc_velocity = calc_velocity.rotated(rotation)
	velocity = calc_velocity

	
	move_and_slide()


var flip = false

func _on_after_image_2d_frame_spawned(frame: Sprite2D) -> void:
	
	pass
	
	#flip = !flip
	#
	#if(flip):
		#$AfterImage2D.modulate = Color(1.0, 0.0, 0.0, 1.0)
	#else:
		#$AfterImage2D.modulate = Color(0.0, 1.0, 0.388, 1.0)
	#
	#$AfterImage2D.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))
