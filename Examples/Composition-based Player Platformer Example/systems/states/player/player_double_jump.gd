# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerDoubleJump
extends CharacterState


## Required dependency to be set for knowing when a double jump can be done.
@export var _jump_state:PlayerJumpState

## Whether it's possible to perform a double jump.
var _can_double_jump:bool = false

## Whether the double jump has been inputted (for knowing when to enter this state).
var inputted_double_jump:bool = false


func can_override_other_states() -> bool:
	return true


func _ready() -> void:
	super()
	# Only connects if it isn't null to prevent errors
	if _jump_state:
		_jump_state.jumped.connect(_on_jumped)


func _get_required_property_dependencies() -> Array[String]:
	return Utils.append_and_return(super(), "_jump_state")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and _can_double_jump:
		inputted_double_jump = true


func can_run() -> bool:
	if inputted_double_jump:
		return true
	else:
		return false


func _on_entered() -> void:
	_play_animation("double_jump")
	_jump_state.update_velocity_for_jump()
	_can_double_jump = false
	inputted_double_jump = false


func _physics_frame(_delta:float) -> void:
	if character_body.is_on_floor() and _can_double_jump:
		_can_double_jump = false


func _on_jumped() -> void:
	await get_tree().process_frame
	_can_double_jump = true
