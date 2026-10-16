# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
@abstract
class_name PlayerState
extends State


@warning_ignore("unused_private_class_variable")
@export var _player:Player
@warning_ignore("unused_private_class_variable")
@export var _sprite:AnimatedSprite2D


func _get_required_property_dependencies() -> Array[String]:
	return ["_player", "_sprite"]


func run() -> void:
	if not _player:
		push_error("Cannot enter state without required dependency '_player'!")
	else:
		await super()


func _play_animation(animation_name:String) -> void:
	if animation_name.is_empty():
		return
	elif not _sprite:
		push_error("Cannot play animation '%s' since no sprite is set!")
		return
	else:
		_sprite.play(animation_name)


func _get_configuration_warnings() -> PackedStringArray:
	return Utils.append_dependencies_configuration_warnings(self, ["_player", "_sprite"])
