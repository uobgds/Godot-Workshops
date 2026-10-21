# ---------------------------------------------------------------------------------------------- #
## A [Node] that can enforce hard property dependencies, ensuring they aren't [code]null[/code]
## or produces errors if they are.
##
## This is used by [State] and [StateMachine] since they both can have dependencies defined and
## enforced!
# ---------------------------------------------------------------------------------------------- #


@tool
@abstract
class_name PropertyDependencyEnforcer
extends Node



# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Contains the names of any properties from [method _get_required_dependency_properties] that have [code]
## null[/code] values.
var _missing_dependency_properties:Array[String] = []

## If [code]true[/code] then [method has_property_dependencies] will be enforced using [method assert].
@export var _assert_property_dependencies:bool = false

## If [code]true[/code], then [member Node.process_mode] will be set to [enum Node.ProcessMode.PROCESS_MODE_DISABLED]
## when there's missing dependencies.
@export var _prevent_processing_with_missing_dependencies:bool = true



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Enforces property dependencies.
func _ready() -> void:
	_checked_required_dependencies()


## Any property names that are returned by this method will be used to determine the hard dependencies
## that must not be [code]null[/code] (see [method _check_property_dependencies]).
## [br][color=khaki][b]WARNING[/b]: Make sure all returned property names actually exist, or warnings
## may be produced.
## [br][br]Override this in any sub-classes to implement dependencies.
func _get_required_dependency_properties() -> Array[String]:
	return []


## Returns the message for a missing property dependency [param property_name].
func _get_missing_required_property_dependency_message(property_name:String) -> String:
	if _assert_property_dependencies:
		return "Missing required required property dependency: %s" % property_name
	else:
		return "Missing required property dependency: %s" % property_name


## Returns [code]true[/code] if [member _missing_dependency_properties] is empty.
func has_required_dependencies() -> bool:
	return _missing_dependency_properties.is_empty()


## Checks all property dependencies and updates all relevant properties.
func _checked_required_dependencies() -> void:
	_missing_dependency_properties.clear()
	for property_dependency in _get_required_dependency_properties():
		if not property_dependency in self:
			push_error(DSM.prepend_node_info(self, "Invalid property dependency '%s'!" % property_dependency
				+ " Property not found? Ignoring..."))
		elif not get(property_dependency):
			_missing_dependency_properties.append(property_dependency)
	if _missing_dependency_properties.is_empty():
		_on_dependencies_satisfied()
	else:
		_on_missing_dependencies()
	update_configuration_warnings()


# Adds any missing property dependencies.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings:Array[String] = []
	for property_dependency in _missing_dependency_properties:
		warnings.append(_get_missing_required_property_dependency_message(property_dependency))
	if not _missing_dependency_properties.is_empty():
		if _assert_property_dependencies:
			warnings.append("An exception will be thrown if these dependencies aren't updated (due"
				+ " to _assert_property_dependencies = true)!")
		warnings.append("You may need to reload saved scene (Scene -> Reload Saved Scene) to update this warning...")
	return warnings


## Called after [signal Node.ready] when there are missing required dependencies.
func _on_missing_dependencies() -> void:
	var required_dependency_properties := _get_required_dependency_properties()
	var error_message := "Missing required property dependencies: %s!" % [_missing_dependency_properties]
	if _assert_property_dependencies:
		assert(required_dependency_properties, error_message)
	else:
		push_error(DSM.prepend_node_info(self, error_message))
	if _prevent_processing_with_missing_dependencies and not Engine.is_editor_hint():
		process_mode = Node.PROCESS_MODE_DISABLED


## Called after [signal Node.ready] when all required dependencies have been set.
func _on_dependencies_satisfied() -> void:
	pass
