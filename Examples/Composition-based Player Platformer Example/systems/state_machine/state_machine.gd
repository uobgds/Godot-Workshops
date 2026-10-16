# ---------------------------------------------------------------------------------------------- #
## Manages any child [State]s, running the next one that can runs and switching when it can't.
## 
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name StateMachine
extends Node


signal terminated

var _states:Array[State] = []
var _overriding_capable_states:Array[State] = []
var _current_state:State
var _overidding_state:State
var _terminated:bool = false
@export var _stop_processing_on_termination:bool = true


func _ready() -> void:
	_setup_states()


func _setup_states() -> void:
	for child in get_children():
		if child is State:
			var state:State = child
			_setup_state(state)


func _setup_state(state:State) -> void:
	state.terminated.connect(_on_termination)
	_states.append(state)
	if state.can_override_other_states():
		_overriding_capable_states.append(state)


func run_state_loop() -> void:
	while not _terminated:
		_current_state = _get_next_state(_current_state)
		if _current_state:
			await _run_state(_current_state)
		await get_tree().process_frame


func _get_next_state(current_state:State) -> State:
	if _overidding_state:
		return _overidding_state
	for state in _states:
		if state == current_state:
			continue
		elif state.can_run():
			return state
	return null


func _get_interrupting_state() -> State:
	for state in _overriding_capable_states:
		if state.can_run():
			return state
	return null


func _run_state(state:State) -> void:
	if _overidding_state == state:
		_overidding_state = null
	state.run()
	while state.running and not _overidding_state:
		await get_tree().process_frame


func stop() -> void:
	pass


func _on_termination() -> void:
	_terminated = true
	if _stop_processing_on_termination:
		for state in _states:
			state.queue_free()
	terminated.emit()


func _process(_delta:float) -> void:
	if Engine.is_editor_hint():
		return
	elif not _overidding_state:
		_overidding_state = _get_interrupting_state()
