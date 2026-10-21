# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerFallingState
extends CharacterState


@export var _falling_animation_name:String = "falling"


func can_run() -> bool:
	if character_body.is_on_floor():
		return false
	elif character_body.velocity.y <= 0:
		return false
	else:
		return true


func _start_running() -> void:
	_play_animation(_falling_animation_name)
