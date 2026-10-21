# ---------------------------------------------------------------------------------------------- #
## This just has some helpful static functions!
# ---------------------------------------------------------------------------------------------- #

@tool
class_name DSM
extends EditorPlugin


const DEPENDENCY_CONFIGURATION_WARNING:String = "The required dependency '%s' is not set!"


static func append_dependency_configuration_warning(node:Node, dependency_property_name:String, 
	warnings:Array[String] = []) -> Array[String]:
		if not node.get(dependency_property_name):
			warnings.append("Required dependency '%s' is not set!" % [node.name, node.get_path(), 
				dependency_property_name])
		return warnings

static func append_dependencies_configuration_warnings(node:Node, dependencies_property_names:Array[String],
	warnings:Array[String] = []) -> Array[String]:
	for property_name in dependencies_property_names:
		append_dependency_configuration_warning(node, property_name, warnings)
	return warnings

static func append_and_return(array:Array, new_value:Variant) -> Array:
	if new_value is Array:
		var new_array:Array = new_value
		array.append_array(new_array)
	else:
		array.append(new_value)
	return array

static func prepend_node_info(node:Node, string:String) -> String:
	return "[%s @ %s] %s" % [node.name, node.get_path(), string]

static func prepend_script_info(string:String, stack_offset:int = 0) -> String:
	var error_stack_frame:Dictionary = get_stack()[stack_offset + 1]
	var source_script:String = error_stack_frame.source
	source_script = source_script.get_file()
	var function:String = error_stack_frame.function
	var line:int = error_stack_frame.line
	return "%s:%s @ %s: %s" % [source_script, line, function, string]

static func get_formatted_node_error(node:Node, error:String, stack_offset:int = 0) -> String:
	var error_stack_frame:Dictionary = get_stack()[stack_offset + 1]
	var source_script:String = error_stack_frame.source
	source_script = source_script.get_file().get_basename()
	var function:String = error_stack_frame.function
	var line:int = error_stack_frame.line
	return "[%s (%s.%s:%s) @ %s] %s" % [node.name, source_script, function, line, node.get_path(), error]
