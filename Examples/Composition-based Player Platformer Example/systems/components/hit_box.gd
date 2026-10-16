# ---------------------------------------------------------------------------------------------- #
## For detecting 'attacks' from [HurtBox]s via 
## [url=https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html]physics 
## collisions[/url], abstracted into [signal hit].
##
## The primary way to use this is by just connecting to [signal hit]. It might also be useful
## to use [method set_hurt_box_immunity] (check its description for more info). 
##
## [br][br]See also [HurtBox].
# ---------------------------------------------------------------------------------------------- #


# The @tool annotation is technically not necessary. It's just there so the collision mask/layers
# can be visibly updated within the editor to prevent possible confusion.
@tool 
class_name HitBox
extends Area2D



# --- Signals --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Emitted whenever it detects a [HurtBox] that doesn't have immunity (see [method set_hurt_box_immunity]).
signal hit(hurt_box:HurtBox)



# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Maps [Node]s to how many [signal SceneTree.physics_frame]s to ignore their children [HurtBox]s for.
## We use the [HurtBox] parent (opposed to just the [HurtBox]) so immunity can be added to a [HurtBox]
## without requiring a reference to it (e.g. adding immunity against an [Enemy]'s [HurtBox] by just
## using a reference of the [Enemy]. [br]The [Dictionary]'s [b]key[/b] is the [Node] that has the child [HurtBox]
## we want to ignore and the [Dictionary]'s [b]value[/b] is the number of [signal SceneTree.physics_frame]s
## left we are ignoring for.
var _hurt_box_parent_immunity_physics_frames_left:Dictionary[Node, int] = {}



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Sets up collision mask/layers and signals.
func _ready() -> void:
	collision_layer = 0 # Sets all collision layers to off.
	collision_mask = 0 # Sets all collision masks to off.
	# Sets the hitbox layer to true, so other [HurtBox]s can detect it.
	set_collision_layer_value(2, true) 
	# Sets the hurtbox mask to true, so it can detect other [HurtBox]s.
	set_collision_mask_value(3, true) 
	# Connects to [signal Area2D.area_entered] so it can detect other [Area2D]s entering it (i.e. other [HurtBox]s).
	area_entered.connect(_on_area_entered) 


## Processes a [HurtBox], emitting [signal hit] unless it has immunity to it (see [member _hurt_box_parent_immunity_physics_frames_left]).
func _process_hurt_box(hurt_box:HurtBox) -> void:
	var hit_box_owner := hurt_box.get_parent()
	if _hurt_box_parent_immunity_physics_frames_left.has(hit_box_owner):
		return
	else:
		hit.emit(hurt_box)


## Ignores any child [HurtBox]s of [param hurt_box_parent] for a total of [param immunity_physics_frames] 
## (see [signal SceneTree.physics_frame]).
func set_hurt_box_immunity(hurt_box_parent:Node, immunity_physics_frames:int) -> void:
	_hurt_box_parent_immunity_physics_frames_left[hurt_box_parent] = immunity_physics_frames


## Decrements all the physics frames left within [member _hurt_box_parent_immunity_physics_frames_left],
## removing any [HitBox] parents that have less than [code]1[/code] frames left.
## I.e. Subtracts 1 from [member _hurt_box_parent_immunity_physics_frames_left]'s [b]values[/b] and
## removes any of its [b]keys[b] if its corresponding [b]value[/b] is [code]<= 0[/code].
## Should be only called a [signal SceneTree.physics_frame] (i.e. within [method Node._physics_process]).
func _update_hurt_box_parent_immunity_frames_left() -> void:
	for hurt_box_owner:Node in _hurt_box_parent_immunity_physics_frames_left.keys():
		var new_frames := _hurt_box_parent_immunity_physics_frames_left[owner] - 1
		if new_frames <= 0:
			_hurt_box_parent_immunity_physics_frames_left.erase(owner)
		else:
			_hurt_box_parent_immunity_physics_frames_left[owner] = new_frames


## Called on [signal Area2D.area_entered].
func _on_area_entered(area:Area2D) -> void:
	if area is HurtBox:
		var hurt_box:HurtBox = area
		_process_hurt_box(hurt_box)


# Updates immunity frames left each physics frame.
func _physics_process(_delta:float) -> void:
	_update_hurt_box_parent_immunity_frames_left()
