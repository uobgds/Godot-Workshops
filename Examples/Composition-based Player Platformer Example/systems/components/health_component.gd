# ---------------------------------------------------------------------------------------------- #
## Implements health, taking damage and detecting death.
##
## 
# ---------------------------------------------------------------------------------------------- #


@tool
class_name HealthComponent
extends Node



# --- Signals --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Emitted whenever [member _health] is deducted.
signal damaged

## Emitted when [member _health] is [code]<= 0[/code].
signal died



# --- Dependencies --- #
																									
# ----------------------------------------------------------------------------------------------- #


## [b]Required Dependency![/b] Used for taking damage from any detected
## [HurtBox]s.
@export var _hit_box:HitBox



# --- Parameters --- #
																									
# ----------------------------------------------------------------------------------------------- #


## How many hit points left until death.
@export var _health:int = 1



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Setup
func _ready() -> void:
	if _hit_box: # Prevents null access errors.
		_hit_box.hit.connect(_on_hit)


## Called on [signal _hit_box.hit].
func _on_hit(hurt_box:HurtBox) -> void:
	_health = maxi(0, _health - hurt_box.damage)
	damaged.emit()
	if _health == 0:
		# Waits a process frame to allow the damage to be processed (i.e. by switching to a hurt state)
		# first.
		await get_tree().process_frame 
		_hit_box.hit.disconnect(_on_hit)
		died.emit()
		hurt_box.register_kill() # So the [HurtBox] knows it got a kill.


# Shows an editor warning if [_hit_box] isn't set.
func _get_configuration_warnings() -> PackedStringArray:
	return Utils.append_dependencies_configuration_warnings(self, ["_hit_box"])
