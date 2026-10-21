# ---------------------------------------------------------------------------------------------- #
## An abstract class for defining logic to be run in a contained manner.
# ---------------------------------------------------------------------------------------------- #


@tool
@abstract
class_name State
extends PropertyDependencyEnforcer



# --- Signals --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Emitted when this [State] first begins to run.
signal started_running

## Emitted when this [State] is no longer running.
signal ended_running



# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Whether this [State] is currently being ran.
var _running:bool = false



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


func _ready() -> void:
	await get_parent().ready # Awaits for any dependencies to be set, to prevent errors!
	super() # Make sures to call super class logic (for checking dependencies).


## Returns whether this [State] is able to run and controls when it will be entered/exited.
@abstract func can_run() -> bool


## Does the enter/exit functionality of this [State], acting as a coroutine for awaiting this
## [State]'s running.
func run() -> void:
	if not has_required_dependencies():
		push_error(DSM.prepend_node_info(self, "Cannot run the state %s since it's missing required dependencies!"))
		return
	_running = true
	@warning_ignore("redundant_await")
	_start_running()
	started_running.emit()
	while can_run() and _running:
		await get_tree().process_frame
	@warning_ignore("redundant_await")
	await _finish_up_running()
	_running = false
	ended_running.emit()


## Called when this [State] first starts running.
func _start_running() -> void:
	pass


## Called when this [State] is finished running, including when its overridden.
func _finish_up_running() -> void:
	pass


## Forcefully stops this [State] from running, used for overriding.
func exit() -> void:
	_running = false
	await ended_running


## Returns [member __running].
func is_running() -> bool:
	return _running
