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

@export var _immunity_frames_on_damage:int

var _hurt_box_parent_immunity_physics_frames_left:Dictionary[Node, int] = {}



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Setup
func _ready() -> void:
	if _hit_box: # Prevents null access errors.
		_hit_box.hit.connect(_on_hit)


func _process_hurt_box(hurt_box:HurtBox) -> void:
	set_hurt_box_immunity(hurt_box.get_parent(), _immunity_frames_on_damage)
	_health = maxi(0, _health - hurt_box.damage)
	damaged.emit()
	if _health == 0:
		# Waits a process frame to allow the damage to be processed (i.e. by switching to a hurt state)
		# first.
		await get_tree().process_frame 
		_hit_box.hit.disconnect(_on_hit)
		died.emit()
		hurt_box.register_kill() # So the [HurtBox] knows it got a kill.


## Ignores any child [HurtBox]s of [param hurt_box_parent] for a total of [param immunity_physics_frames] 
## (see [signal SceneTree.physics_frame]).
func set_hurt_box_immunity(hurt_box_parent:Node, immunity_physics_frames:int) -> void:
	_hurt_box_parent_immunity_physics_frames_left[hurt_box_parent] = immunity_physics_frames


## Called on [signal _hit_box.hit].
func _on_hit(hurt_box:HurtBox) -> void:
	var hurt_box_parent := hurt_box.get_parent()
	if hurt_box_parent == get_parent():
		return
	elif _hurt_box_parent_immunity_physics_frames_left.has(hurt_box_parent):
		return
	else:
		_process_hurt_box(hurt_box)


## Decrements all the physics frames left within [member _hurt_box_parent_immunity_physics_frames_left],
## removing any [HitBox] parents that have less than [code]1[/code] frames left.
## I.e. Subtracts 1 from [member _hurt_box_parent_immunity_physics_frames_left]'s [b]values[/b] and
## removes any of its [b]keys[b] if its corresponding [b]value[/b] is [code]<= 0[/code].
## Should be only called a [signal SceneTree.physics_frame] (i.e. within [method Node._physics_process]).
func _update_hurt_box_parent_immunity_frames_left() -> void:
	for hurt_box_parent:Node in _hurt_box_parent_immunity_physics_frames_left.keys():
		var new_frames := _hurt_box_parent_immunity_physics_frames_left[hurt_box_parent] - 1
		if new_frames <= 0:
			_hurt_box_parent_immunity_physics_frames_left.erase(hurt_box_parent)
		else:
			_hurt_box_parent_immunity_physics_frames_left[hurt_box_parent] = new_frames


# Shows an editor warning if [_hit_box] isn't set.
func _get_configuration_warnings() -> PackedStringArray:
	return DSM.append_dependencies_configuration_warnings(self, ["_hit_box"])


# Updates immunity frames left each physics frame.
func _physics_process(_delta:float) -> void:
	_update_hurt_box_parent_immunity_frames_left()
