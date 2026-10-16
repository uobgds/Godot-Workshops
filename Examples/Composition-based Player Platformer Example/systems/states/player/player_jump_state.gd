# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerJumpState
extends CharacterState


signal jumped


@export var _jump_speed:float = 200
var _can_jump:bool = false


func can_run() -> bool:
	if Input.is_action_pressed("jump") and _can_jump:
		return true
	else:
		return false


func _on_entered() -> void:
	_play_animation("jump")
	update_velocity_for_jump()
	jumped.emit()
	_can_jump = false


func _physics_frame(_delta:float) -> void:
	if not _can_jump and character_body.is_on_floor():
		_can_jump = true


func update_velocity_for_jump() -> void:
	character_body.velocity.y = - _jump_speed
