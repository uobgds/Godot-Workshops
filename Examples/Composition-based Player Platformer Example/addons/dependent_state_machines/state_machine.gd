# ---------------------------------------------------------------------------------------------- #
## A simple implementation of a state machine, for defining behaviour using a finite number of
## [State]s. 
##
## You can extend this class if you'd like to add any dependencies
# ---------------------------------------------------------------------------------------------- #


@tool
class_name StateMachine
extends PropertyDependencyEnforcer



# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


#region Properties:

## Contains all managing [State]s, which can potentially be run during [method _do_state_loop].
var _states:Array[State] = []

## The [State] that is currently being run, or [code]null[/code] if no [State] is being run.
var _currently_running_state:State

## All [State]s that are currently runnable (see [method State.can_run]).
var _runnable_states:Array[State]

# Enable these to get debug messages in output, useful for finding bugs!
@export_group("Debug Messages")
## Prints a debug message when a [State] starts running.
@export var _state_started_running_debug_messages:bool = false
## Prints a debug message when a [State] has finished running.
@export var _state_finished_running_debug_messages:bool = false
## Prints a debug message when any [State] is/isn't runnable.
@export var _runnable_states_updates_debug_messages:bool = false
## Prints a debug message when [member _currently_running_state] was overrided.
@export var _current_state_overrided_debug_messages:bool = false
## Prints a debug message when no [State] is being run.
@export var _no_running_state_debug_messages:bool = false

#endregion




# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


#region Listeners:


func _on_missing_dependencies() -> void:
	super()
	push_error(DSM.prepend_node_info(self, "Disabling functionality due to missing required dependencies..."))


func _on_dependencies_satisfied() -> void:
	_setup_states()

 
# Tries overriding current state.
func _process(_delta:float) -> void:
	if Engine.is_editor_hint():
		return
	elif has_required_dependencies():
		_update_runnable_states()
		_update_current_state()


#endregion


func _update_current_state() -> void:
	if _runnable_states.is_empty():
		if not _currently_running_state and _no_running_state_debug_messages:
			print(DSM.prepend_node_info(self, "No currently running state!"))
	else:
		var next_runnable_state:State = _runnable_states.front()
		if _currently_running_state:
			var currently_running_state_priority:int = _currently_running_state.get_index()
			var next_runnable_state_priority:int = next_runnable_state.get_index()
			if next_runnable_state_priority < currently_running_state_priority:
				_run_state(next_runnable_state)
			else:
				return
		else:
			_run_state(next_runnable_state)


func _run_state(new_state:State) -> void:
	if _currently_running_state and _currently_running_state.is_running():
		if _current_state_overrided_debug_messages:
			print(DSM.prepend_node_info(self, "Current state '%s'" % _currently_running_state.name
				+ " is being overrided by the new state '%s'" % new_state.name))
		await _currently_running_state.exit()
	_currently_running_state = new_state
	_currently_running_state.run()


## 'Sets up' all children [State]s (see [method _setup_state]).
func _setup_states() -> void:
	_states.clear()
	for child in get_children():
		if child is State:
			var state:State = child
			_setup_state(state)


## 'Sets up' [param state] by allowing it to be chosen (see [method _choose_next_state]) and terminate
## this [StateMachine] (see [method terminate]).
##
## [br][br]This is done by adding [param state] to [member _states] (and [member _overriding_capable_states] 
## if relevant), as well as connecting [method terminate] to [signal State.termination_requested].
func _setup_state(state:State) -> void:
	_set_state_dependencies(state)
	if not state.has_required_dependencies():
		push_error(DSM.prepend_node_info(self, "Can't add state '%s' as its missing required dependencies!" % state.name))
	_states.append(state)
	state.started_running.connect(_on_state_started_running.bind(state))
	state.ended_running.connect(_on_state_ended_running.bind(state))


## Stops the running of any future [State]s, as well as stopping any processing of this [StateMachine]
## and its [member _states] if [member _stop_processing_on_termination] is [code]true[/code] (see 
## [member _stop_processing_on_termination]).
func stop_processing() -> void:
	process_mode =Node.PROCESS_MODE_DISABLED


@warning_ignore("unused_parameter")
func _set_state_dependencies(state:State) -> void:
	pass


func _update_runnable_states() -> void:
	for state in _states:
		if not _runnable_states.has(state) and state.can_run():
			_add_runnable_state(state)
		elif _runnable_states.has(state) and not state.can_run():
			_remove_runnable_state(state)


func _add_runnable_state(new_state:State) -> void:
	if _runnable_states_updates_debug_messages:
		print(DSM.prepend_node_info(self, "State runnable: '%s'" % new_state.name))
	for i in range(_runnable_states.size()):
		var state := _runnable_states[i]
		if new_state.get_index() < state.get_index():
			_runnable_states.insert(i, new_state)
			return
		else:
			continue
	_runnable_states.append(new_state)


func _remove_runnable_state(state:State) -> void:
	_runnable_states.erase(state)
	if _runnable_states_updates_debug_messages:
		print(DSM.prepend_node_info(self, "State no longer runnable: '%s'" % state.name))


func _on_state_started_running(state:State) -> void:
	if _state_started_running_debug_messages:
		print(DSM.prepend_node_info(self, "Started running state '%s'" % state.name))


func _on_state_ended_running(state:State) -> void:
	if _state_finished_running_debug_messages:
		print(DSM.prepend_node_info(self, "Stopped running state '%s'" % state.name))
	_currently_running_state = null
