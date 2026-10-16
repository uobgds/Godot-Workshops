# ---------------------------------------------------------------------------------------------- #
##
# ---------------------------------------------------------------------------------------------- #


@tool
class_name Utils


static func append_dependency_configuration_warning(node:Node, dependency_property_name:String, 
	warnings:Array[String] = []) -> Array[String]:
		if not node.get(dependency_property_name):
			warnings.append("The required dependency '%s' is not set!" % dependency_property_name)
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
