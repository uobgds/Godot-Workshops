# ---------------------------------------------------------------------------------------------- #
## Abstract base class for any enemies. Technically not needed since it doesn't do much.
# ---------------------------------------------------------------------------------------------- #


@abstract
class_name Enemy
extends Entity


## Overrides to return [code]true[/code] if [param node] is the [Player].
func _can_take_damage(node:Node) -> bool:
	if node is Player:
		return true
	else:
		return false
