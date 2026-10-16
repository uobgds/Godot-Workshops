# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerHurtState
extends CharacterState


@export var _health_component:HealthComponent
var _just_hurt:bool = false


func can_override_other_states() -> bool:
	return true


func _get_required_property_dependencies() -> Array[String]:
	return Utils.append_and_return(super(), "_health_component")


func _ready() -> void:
	super()
	if _health_component: # Only connects if it isn't null to prevent null access errors.
		_health_component.damaged.connect(_on_damaged)


func can_run() -> bool:
	if _just_hurt:
		return true
	else:
		return false


func _on_entered() -> void:
	_just_hurt = false
	await _play_animation("hurt")


func _on_damaged() -> void:
	_just_hurt = true
