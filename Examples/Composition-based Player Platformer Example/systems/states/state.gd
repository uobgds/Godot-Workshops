# ---------------------------------------------------------------------------------------------- #
## An abstract class for managing
# ---------------------------------------------------------------------------------------------- #


@tool
@abstract
class_name State
extends Node


@warning_ignore("unused_signal")
signal terminated

signal exited


var running:bool = false
var _missing_dependencies:Array[String] = []
var has_all_required_dependencies:bool:
	get:
		return _missing_dependencies.is_empty()



func _ready() -> void:
	_check_dependencies()


func can_override_other_states() -> bool:
	return false


func _get_required_property_dependencies() -> Array[String]:
	return []


func _check_dependencies() -> void:
	await get_parent().ready
	for property_dependency in _get_required_property_dependencies():
		if not get(property_dependency):
			push_error("Missing required dependency: %s" % property_dependency)
			_missing_dependencies.append(property_dependency)
	if not has_all_required_dependencies:
		push_error("Will not enter due to missing dependencies!")


@abstract func can_run() -> bool


func run() -> void:
	if not has_all_required_dependencies:
		push_error("Cannot run the state %s since it's missing required dependencies!")
		return
	print("Entering state: %s" % name)
	running = true
	@warning_ignore("redundant_await")
	await _on_entered()
	while can_run() and running:
		await get_tree().process_frame
	@warning_ignore("redundant_await")
	await _on_exited()
	running = false
	print("Exited state")
	exited.emit()


func _on_entered() -> void:
	pass


func _on_exited() -> void:
	pass


func _physics_process(delta:float) -> void:
	if Engine.is_editor_hint() or not has_all_required_dependencies:
		return
	else:
		_physics_frame(delta)


@warning_ignore("unused_parameter")
func _physics_frame(delta:float) -> void:
	pass


func _get_configuration_warnings() -> PackedStringArray:
	return Utils.append_dependencies_configuration_warnings(self, _get_required_property_dependencies())
