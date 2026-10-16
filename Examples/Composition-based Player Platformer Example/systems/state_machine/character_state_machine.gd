# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name CharacterStateMachine
extends StateMachine


# Dependencies:
@export var _character_body:CharacterBody2D
@export var _sprite:AnimatedSprite2D


func _ready() -> void:
	if not _character_body or not _sprite:
		push_error("Missing")
	super()


func _check_dependencies() -> void:
	var missing_dependency:bool = false
	if not _character_body:
		push_error("Missing required dependency: %s" % _character_body)
		missing_dependency = true
	if not _sprite:
		push_error("Missing required dependency: %s" % _sprite)
		missing_dependency = true
	if missing_dependency:
		push_error("Not all required dependencies set! States may not enter...")


# Overridden to setup dependencies of any [CharacterState]s.
func _setup_state(state:State) -> void:
	super(state)
	if state is CharacterState:
		var character_state:CharacterState = state
		character_state.character_body = _character_body
		character_state.sprite = _sprite


func _get_configuration_warnings() -> PackedStringArray:
	return Utils.append_dependencies_configuration_warnings(self, ["_character_body", "_sprite"])
