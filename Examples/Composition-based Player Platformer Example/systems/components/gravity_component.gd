# ---------------------------------------------------------------------------------------------- #
## Applies gravity to a [CharacterBody2D].
##
## To use, you must set [member _character_body] to the [CharacterBody2D] to apply gravity to. 
## You can change the parameters to change its behaviour.
## 
## [br][br][color=khaki][b]WARNING:[/b] Make sure [member _terminal_speed] is an appropriate value
## or unexpected overriding might occur!
# ---------------------------------------------------------------------------------------------- #


@tool
class_name GravityComponent
extends Node




# --- Dependencies --- #
																									
# ----------------------------------------------------------------------------------------------- #


## [b]Required Depndency![/b] The [CharacterBody2D] to apply gravity to.
@export var _character_body:CharacterBody2D



# --- Parameters --- #
																									
# ----------------------------------------------------------------------------------------------- #


## The value to add to [member _character_body.velocity] each second.
@export var _gravity_acceleration:float = 1

## The maximum value of [member _character_body.velocity.y] (enforced based on [member _hard_limit_termianl_speed]).
## [br][color=khaki][b]WARNING:[/b] Make sure this is a appropriate relative to [member _gravity_acceleration]
## or weird overriding might happen, especially if [member _hard_limit_termianl_speed] is [code]true[/code].
## The default values should be safe.
@export var _terminal_speed:float = 20

## If set to [code]true[/code], [member _character_body.velocity.y] will be overridden if it's ever
## above [member _terminal_speed].
@export var _hard_limit_terminal_speed:bool = false

## Whether to apply gravity on [member _character_body] or not.
@export var _enabled:bool = true



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Pushes errors if any required dependencies aren't set.
func _ready() -> void:
	if not _character_body:
		push_warning("No _character_body set! Will do nothing...")


func _physics_process(delta:float) -> void:
	if Engine.is_editor_hint():
		return
	elif _enabled and _character_body:
		_apply_gravity(delta)


## Applies gravity based on parameters to [member _character_body] (if it's set).
func _apply_gravity(delta:float) -> void:
	# Doesn't change the velocity if it's above terminal speed and [member _hard_limit_terminal_speed]
	# is [code]false[/code], in case another script needs this behaviour.
	if _character_body.velocity.y > _terminal_speed and not _hard_limit_terminal_speed: 
		return
	else:
		# The acceleration to apply this physics frame based on delta.
		var delta_velocity := _gravity_acceleration * delta 
		var new_velocity := _character_body.velocity.y + delta_velocity # Changed velocity.
		# Caps velocity at _terminal_speed.
		_character_body.velocity.y = minf(new_velocity, _terminal_speed) 


# Warning if [member _character_body] isn't set.
func _get_configuration_warnings() -> PackedStringArray:
	return Utils.append_dependency_configuration_warning(self, "_character_body")
