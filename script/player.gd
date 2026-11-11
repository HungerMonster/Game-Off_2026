extends CharacterBody2D

@export var gravity_strength: float = 10.0
@export var change_gravity_cooldown: float = 0.5 
var current_gravity_direction: Vector2 = Vector2.DOWN 
var is_landing: bool = false
var gravity_cooldown_timer: float = 0.0 
@onready var anim_player = $AnimatedSprite2D

func _physics_process(delta):
	if gravity_cooldown_timer > 0:
		gravity_cooldown_timer -= delta
	
		if not is_on_floor():
			velocity += current_gravity_direction * gravity_strength
			is_landing = false
		
		if anim_player.animation != "fall":
			anim_player.play("fall")
		
	else:
		if velocity.dot(current_gravity_direction) > 0:
			velocity = Vector2.ZERO
			is_landing = true
		
		if anim_player.animation != "idle":
			anim_player.play("idle")

	move_and_slide()

func _input(event):
	if gravity_cooldown_timer <= 0:
		if event.is_action_pressed("change_gravity"):
			if Input.is_key_pressed(KEY_SHIFT):
				
				gravity_cooldown_timer = change_gravity_cooldown
				if Input.is_key_pressed(KEY_CTRL):
					cycle_gravity(false)
				else:
					cycle_gravity(true)
					
			else:
				pass
		
		if Input.is_action_just_pressed("mobile_clockwise"):
			gravity_cooldown_timer = change_gravity_cooldown
			cycle_gravity(true)
		elif Input.is_action_just_pressed("mobile_counterclockwise"):
			gravity_cooldown_timer = change_gravity_cooldown
			cycle_gravity(false)



func cycle_gravity(clockwise: bool):
	if clockwise:
		if current_gravity_direction == Vector2.DOWN:
			current_gravity_direction = Vector2.LEFT
			up_direction = Vector2.RIGHT
			anim_player.rotation = deg_to_rad(90)
		elif current_gravity_direction == Vector2.LEFT:
			current_gravity_direction = Vector2.UP
			up_direction = Vector2.DOWN
			anim_player.rotation = deg_to_rad(180)
		elif current_gravity_direction == Vector2.UP:
			current_gravity_direction = Vector2.RIGHT
			up_direction = Vector2.LEFT
			anim_player.rotation = deg_to_rad(-90)
		elif current_gravity_direction == Vector2.RIGHT:
			current_gravity_direction = Vector2.DOWN
			up_direction = Vector2.UP
			anim_player.rotation = deg_to_rad(0)
	else:
		if current_gravity_direction == Vector2.DOWN:
			current_gravity_direction = Vector2.RIGHT
			up_direction = Vector2.LEFT
			anim_player.rotation = deg_to_rad(-90)
		elif current_gravity_direction == Vector2.RIGHT:
			current_gravity_direction = Vector2.UP
			up_direction = Vector2.DOWN
			anim_player.rotation = deg_to_rad(180)
		elif current_gravity_direction == Vector2.UP:
			current_gravity_direction = Vector2.LEFT
			up_direction = Vector2.RIGHT
			anim_player.rotation = deg_to_rad(90)
		elif current_gravity_direction == Vector2.LEFT:
			current_gravity_direction = Vector2.DOWN
			up_direction = Vector2.UP
			anim_player.rotation = deg_to_rad(0)
