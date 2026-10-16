# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerRunState
extends CharacterState


@export var _running_speed:float = 200


func can_run() -> bool:
	if Input.is_action_pressed("jump"):
		return false
	elif not character_body.is_on_floor():
		return false
	elif Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		return true
	else:
		return false


func _on_entered() -> void:
	_play_animation("run")


func _physics_frame(_delta:float) -> void:
	_update_velocity_for_running()
	_update_sprite_direction()


func _update_velocity_for_running() -> void:
	var direction := Input.get_axis("run_left", "run_right")
	character_body.velocity.x = direction * _running_speed


func _update_sprite_direction() -> void:
	if character_body.velocity.is_zero_approx():
		return
	else:
		sprite.flip_h = character_body.velocity.x < 0
