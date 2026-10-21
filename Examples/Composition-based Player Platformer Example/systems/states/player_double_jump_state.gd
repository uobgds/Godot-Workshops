# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerDoubleJump
extends CharacterState


## Required dependency to be set for knowing when a double jump can be done.
@export var _jump_state:PlayerJumpingState

@export var _double_jump_animation_name:String = "double_jumped"

## Whether it's possible to perform a double jump.
var _can_double_jump:bool = false

## Whether the double jump has been inputted (for knowing when to enter this state).
var inputted_double_jump:bool = false

var _double_jumping:bool = false


func _on_dependencies_satisfied() -> void:
	_jump_state.jumped.connect(_on_jumped)


func _get_required_dependency_properties() -> Array[String]:
	return DSM.append_and_return(super(), "_jump_state")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and _can_double_jump:
		inputted_double_jump = true


func can_run() -> bool:
	if inputted_double_jump:
		return true
	elif _double_jumping:
		return true
	else:
		return false


func _start_running() -> void:
	_double_jumping = true
	_play_animation(_double_jump_animation_name)
	_jump_state.update_velocity_for_jump()
	_can_double_jump = false
	inputted_double_jump = false


func _finish_up_running() -> void:
	await _wait_for_animation_completion()


func _state_physics_process(_delta:float) -> void:
	if character_body.is_on_floor() and _can_double_jump:
		_can_double_jump = false
	elif _double_jumping and character_body.velocity.y >= 0:
		_double_jumping = false


func _on_jumped() -> void:
	await get_tree().process_frame
	_can_double_jump = true
