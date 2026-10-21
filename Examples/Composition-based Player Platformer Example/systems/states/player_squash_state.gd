# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerSquashState
extends CharacterState




# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


# References:

@export var _hurt_box:HurtBox
@export var _health_component:HealthComponent
@export var _successful_hit_immunity_frames:int = 5
@export var _successful_hit_animation_name:String = "double_jumped"
@export var _successful_hit_upward_speed:float = 200


# Variables:

var _successful_hit:bool = false
var _falling:bool = false




# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


func _get_required_dependency_properties() -> Array[String]:
	return DSM.append_and_return(super(), ["_hurt_box"])


func can_run() -> bool:
	if _successful_hit:
		return true
	else:
		return false


func _on_hurt_box_hit(hit_box:HitBox) -> void:
	if hit_box.get_parent() == _hurt_box.get_parent():
		return
	_successful_hit = true
	if _health_component:
		_health_component.set_hurt_box_immunity(hit_box.get_parent(), _successful_hit_immunity_frames)


func _update_falling() -> void:
	if not _falling and not character_body.is_on_floor() and character_body.velocity.y > 0:
		_falling = true
		_hurt_box.hit.connect(_on_hurt_box_hit)
	elif _falling and character_body.is_on_floor():
		_falling = false
		_hurt_box.hit.disconnect(_on_hurt_box_hit)
		_successful_hit = false


func _state_physics_process(_delta:float) -> void:
	_update_falling()


func _start_running() -> void:
	_play_animation(_successful_hit_animation_name)
	character_body.velocity.y = -_successful_hit_upward_speed
	_successful_hit = false


func _finish_up_running() -> void:
	await _wait_for_animation_completion()
