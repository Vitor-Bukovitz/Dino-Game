extends KinematicBody2D

var motion = Vector2(0, 0)

const SPEED = 500
const GRAVITY = 150
const UP = Vector2(0, -1)
const JUMP_SPEED = 2200
var fire_fuel = 500

signal animate

func _physics_process(_delta):
	jump()
	move()
	animate()
	apply_gravity()
	move_and_slide(motion, UP)


func apply_gravity():
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY


func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED


func move():
	if Input.is_action_pressed("down") and is_on_floor() and fire_fuel > 0:
		rotate_fire()
		motion.y = -1
		motion.x = 0
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
		$Sprite.flip_h = true
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
		$Sprite.flip_h = false
	else:
		motion.x = 0
	use_refil_fire()

func animate():
	emit_signal("animate", motion)


func rotate_fire():
	var flipped = $Sprite.flip_h
	if $Fire.scale.x > 0 and flipped or $Fire.scale.x < 0 and not flipped:
		$Fire.scale.x *= -1
		$Fire.position.x *= -1


func use_refil_fire():
	if motion.y == -1 and motion.x == 0:
		fire_fuel -= 5
		if fire_fuel < 0:
			fire_fuel = -50
	elif fire_fuel < 500:
		fire_fuel += 1
	
	var fuel_percentage = (float(fire_fuel) / 500.0) * 100 if fire_fuel > 0 else 0
	get_tree().call_group('GUI', 'refresh_fuel', fuel_percentage)














