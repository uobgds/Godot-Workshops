# ---------------------------------------------------------------------------------------------- #
## A [CharacterBody2D] that moves with its [member velocity] and does behaviour using a
## [CharacterStateMachine].
##
## Update [member velocity] to change the way the [CharacterBody2D] moves (see the class and 
## [method CharacterBody2D.move_and_slide] for more details).
## 
## [br][br]If you want to implement or change behaviour, check [member _state_machine] and its
## child [State]s. You can find more information in [StateMachine].
# ---------------------------------------------------------------------------------------------- #


@tool
class_name StatefulCharacter
extends CharacterBody2D



# --- Dependencies --- #
																									
# ----------------------------------------------------------------------------------------------- #


## [b]Required dependency![/b] Used for running corresponding behaviour.
@export var _state_machine:CharacterStateMachine



# --- Parameters --- #
																									
# ----------------------------------------------------------------------------------------------- #


## If [code]true[/code], it will delete itself on [signal _state_machine.termination].
@export var _delete_on_state_machine_termination:bool = true



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Starts running [member _state_machine] (if it's set).
func _ready() -> void:
	if not _state_machine:
		if _delete_on_state_machine_termination:
			push_warning("Cannot delete on StateMachine termination since none is set!")
	else:
		_start_state_machine() # Only runs if a [StateMachine] is set to prevent null access errors.


## Sets up [member _state_machine] and runs its behaviour.
func _start_state_machine() -> void:
	_state_machine.terminated.connect(_on_state_machine_termination) 
	_state_machine.run_state_loop()


## Called on [signal _state_machine.terminated]. 
func _on_state_machine_termination() -> void:
	if _delete_on_state_machine_termination: # Check its description for more info.
		queue_free()


# Gives an editor	 warning if [member _state_machine] isn't set.
func _get_configuration_warnings() -> PackedStringArray:
	if not _state_machine:
		return ["No _state_machine set! Any child StateMachine will not start."]
	else:
		return []


# Updates position based on [member CharacterBody2D.velocity].
func _physics_process(_delta:float) -> void:
	move_and_slide() # Check documentation for more info on this.
