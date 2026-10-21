# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
@abstract
class_name CharacterState
extends State


@export_group("Required Dependencies")
@export var character_body:CharacterBody2D
@export var animated_sprite:AnimatedSprite2D


func _get_required_dependency_properties() -> Array[String]:
	return ["character_body", "animated_sprite"]


func _play_animation(animation_name:String) -> void:
	if animation_name.is_empty(): # Invalid animation since it's empty.
		return
	else:
		animated_sprite.play(animation_name)
		await _wait_for_animation_completion()


func _wait_for_animation_completion() -> void:
	if not animated_sprite.is_playing():
		return
	var is_looping:bool = animated_sprite.sprite_frames.get_animation_loop(animated_sprite.animation)
	if is_looping:
		await animated_sprite.animation_looped
	else:
		await animated_sprite.animation_finished


# Calls [method _state_physics_process] when relevant. 
func _physics_process(delta:float) -> void:
	if Engine.is_editor_hint() or not has_required_dependencies():
		return
	else:
		_state_physics_process(delta)


## Called from [method _physics_process], only when not in the editor and when dependencies are
## satisfied. Essentially safe for implementing any state logic.
@warning_ignore("unused_parameter")
func _state_physics_process(delta:float) -> void:
	pass
