extends CharacterBody2D

@export var speed = 150.0

func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left") or Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_action_pressed("move_right") or Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_action_pressed("move_up") or Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_action_pressed("move_down") or Input.is_key_pressed(KEY_S):
		direction.y += 1
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()
