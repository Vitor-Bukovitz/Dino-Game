extends AnimationPlayer


func _on_Player_animate(motion):
	if motion.x != 0:
		play("walk")
	elif motion.y == -1 and motion.x == 0:
		play("fire")
	else:
		play("idle")
