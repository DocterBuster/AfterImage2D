extends CharacterBody2D



const JUMP_VELOCITY = -1000.0


const SPEED = 50.0
const SLOWDOWN_RATIO = 0.5
const MAX_SPEED = 500.0

@onready var sprite : Sprite2D = $Sprite2D

## Velcoty math members
var calc_velocity_to_add : Vector2 = Vector2.ZERO
var prev_grav : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	## Change up direction and rotation based on gravity force
	if(prev_grav != get_gravity() and prev_grav != Vector2.ZERO):
		up_direction = Vector2(sign(get_gravity()).x, -sign(get_gravity()).y)
		var tween : Tween = create_tween()
		tween.tween_property(self, "rotation", Vector2.UP.angle_to(up_direction), 0.2)
	prev_grav = get_gravity()
	
	
	
	calc_velocity_to_add = Vector2.ZERO
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED
		velocity.x = clampf(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = sign(velocity.x) == -1
		if(is_on_floor()):
			$AnimationPlayer.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * SLOWDOWN_RATIO)
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += JUMP_VELOCITY * -sign(up_direction.y)
		$AnimationPlayer.play("jump")
	
	## Rotate velcoty based on current rotation & add it!
	#velocity = velocity.rotated(rotation)
	
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
