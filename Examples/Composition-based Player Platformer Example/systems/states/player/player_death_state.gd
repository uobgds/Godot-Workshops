# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerDeathState
extends CharacterState


## Required dependency for knowing when the [Player] died.
@export var _health_component:HealthComponent


var _died:bool = false


func can_override_other_states() -> bool:
	return true


func _get_required_property_dependencies() -> Array[String]:
	return Utils.append_and_return(super(), "_health_component")


func _ready() -> void:
	super()
	if _health_component:
		_health_component.died.connect(_on_died)


func _on_entered() -> void:
	await _play_animation("death")
	terminated.emit()


func _on_died() -> void:
	_died = true


func can_run() -> bool:
	if _died:
		return true
	else:
		return false
