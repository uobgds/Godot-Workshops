# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerRunningState
extends CharacterState


@export var _running_animation_name:String = "running"
@export var _running_speed:float = 200



func can_run() -> bool:
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		return true
	else:
		return false


func _start_running() -> void:
	_play_animation(_running_animation_name)


func _state_physics_process(_delta:float) -> void:
	_update_velocity_for_running()
	_update_sprite_direction()


func _update_velocity_for_running() -> void:
	var direction := Input.get_axis("run_left", "run_right")
	character_body.velocity.x = direction * _running_speed


func _update_sprite_direction() -> void:
	if character_body.velocity.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	elif character_body.velocity.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
