# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerIdleState
extends CharacterState


func can_run() -> bool:
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		return false
	elif Input.is_action_pressed("jump"):
		return false
	elif not character_body.is_on_floor():
		return false
	elif not character_body.velocity.x == 0:
		return false
	else:
		return true


func _on_entered() -> void:
	_play_animation("idle")
