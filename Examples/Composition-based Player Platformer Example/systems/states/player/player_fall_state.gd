# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name PlayerFallState
extends CharacterState



@export var _hurt_box:HurtBox
@export var _hit_box:HitBox
@export var _double_jump_state:PlayerDoubleJump
@export var _successful_hit_immunity_frames:int = 5


func _get_required_property_dependencies() -> Array[String]:
	return Utils.append_and_return(super(), ["_hurt_box", "_hit_box", "_double_jump_state"])


func _ready() -> void:
	super()
	# Disables the [HurtBox] by making it undetectable (see [member Area2D.monitorable]) since 
	# it should only be enabled when the player is falling.
	if _hurt_box:
		_hurt_box.monitorable = false


func can_run() -> bool:
	if _double_jump_state and _double_jump_state.inputted_double_jump:
		return false
	elif character_body.is_on_floor():
		return false
	elif character_body.velocity.y <= 0:
		return false
	else:
		return true


func _on_entered() -> void:
	_play_animation("fall")
	_hurt_box.hit.connect(_on_hit)
	_hurt_box.monitorable = true


func _on_exited() -> void:
	_hurt_box.monitorable = true
	_hurt_box.hit.disconnect(_on_hit)


func _get_configuration_warnings() -> PackedStringArray:
	return Utils.append_dependencies_configuration_warnings(self, ["_hurt_box", "_hit_box"], super())


func _on_hit(hurt_box:HurtBox) -> void:
	if not _hit_box:
		return
	else:
		_hit_box.set_hurt_box_immunity(hurt_box.get_parent(), _successful_hit_immunity_frames)
