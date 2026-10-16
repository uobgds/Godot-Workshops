# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
@abstract
class_name CharacterState
extends State



# Dependencies
var character_body:CharacterBody2D
var sprite:AnimatedSprite2D


func _get_required_property_dependencies() -> Array[String]:
	return ["character_body", "sprite"]


func _play_animation(animation_name:String) -> void:
	if animation_name.is_empty(): # Invalid animation since it's empty.
		return
	elif not sprite: # Doesn't play anything if [member sprite] isn't set to prevent null access errors.
		push_error("Cannot play animation '%s' since no sprite is set!")
		return
	else:
		sprite.play(animation_name)
		# Doesn't wait for animation if none is playing, in case [param animation_name] doesn't
		# exist.
		if not sprite.is_playing():
			return
		else:
			await _wait_for_animation_completion(animation_name)

##
func _wait_for_animation_completion(animation_name:String) -> void:
	var is_looping:bool = sprite.sprite_frames.get_animation_loop(animation_name)
	if is_looping:
		await sprite.animation_looped
	else:
		await sprite.animation_finished
