# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name CharacterStateMachine
extends StateMachine


@export_group("Required Dependencies")
@export var _character_body:CharacterBody2D
@export var _animated_sprite:AnimatedSprite2D


func _get_required_dependency_properties() -> Array[String]:
	return ["_character_body", "_animated_sprite"]


func _set_state_dependencies(state:State) -> void:
	if not state is CharacterState:
		return
	else:
		var character_state:CharacterState = state
		character_state.character_body = _character_body
		character_state.animated_sprite = _animated_sprite
		character_state.update_configuration_warnings()
