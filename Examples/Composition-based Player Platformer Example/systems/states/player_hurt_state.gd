# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerHurtState
extends CharacterState


@export var _health_component:HealthComponent
@export var _hurt_animation_name:String = "hurt"
@export var _damaged_velocity:Vector2 = Vector2(0, -200)
var _received_damage:bool = false


func can_override_other_states() -> bool:
	return true


func _get_required_dependency_properties() -> Array[String]:
	return DSM.append_and_return(super(), "_health_component")


func _ready() -> void:
	super()
	if _health_component: # Only connects if it isn't null to prevent null access errors.
		_health_component.damaged.connect(_on_damaged)


func can_run() -> bool:
	if _received_damage:
		return true
	else:
		return false


func _start_running() -> void:
	_play_animation(_hurt_animation_name)
	character_body.velocity += _damaged_velocity
	_received_damage = false


func _finish_up_running() -> void:
	await _wait_for_animation_completion()


func _on_damaged() -> void:
	_received_damage = true
