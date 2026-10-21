# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerIdleState
extends CharacterState


@export var _idle_animation_name:String = "idle"


func can_run() -> bool:
	return true

func _start_running() -> void:
	_play_animation(_idle_animation_name)
