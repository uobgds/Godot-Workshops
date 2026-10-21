# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerJumpingState
extends CharacterState


signal jumped


@export var _jump_animation_name:String = "jumping"
@export var _jump_speed:float = 200
var _can_jump:bool = false
var _jumping:bool = false


func can_run() -> bool:
	if Input.is_action_pressed("jump") and _can_jump:
		return true
	elif _jumping:
		return true
	else:
		return false


func _start_running() -> void:
	_jumping = true
	_play_animation(_jump_animation_name)
	update_velocity_for_jump()
	jumped.emit()
	_can_jump = false


func _state_physics_process(_delta:float) -> void:
	if not _can_jump and character_body.is_on_floor():
		_can_jump = true
	elif _jumping and character_body.velocity.y >= 0:
		_jumping = false


func update_velocity_for_jump() -> void:
	character_body.velocity.y = - _jump_speed
