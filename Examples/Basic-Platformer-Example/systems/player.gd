# ---------------------------------------------------------------------------------------------- #
## Controls all the player's logic.
# ---------------------------------------------------------------------------------------------- #


class_name Player
extends Entity



#region Parameters (i.e. properties we can edit in the editor to change behaviour):

## How many physics frames to wait after taking damage, so the [Player] isn't hit multiple times
## in quick succession. [br][br]
## A physics frame refers to when [method Node._physics_process] is called, (i.e. [signal SceneTree.physics_frame]).
@export var _immunity_frames_on_hit:int = 5

## How much to set [member CharacterBody2D.velocity.y] to when jumping.
@export var _jump_speed:float = 200

#endregion


## Whether we have jumped or not. This is used for preventing another non-double jump before reaching 
## the ground.
var _jumped:bool = false

## Whether we have double-jumped or not. This is used for preventing another double-jump before
## reaching the ground.
var _double_jumped:bool = false

## Whether we're falling or not. This is used for playing the [Player] fall animation and also
## checking whether we can attack an [Enemy] via 'sqashing' them.
var _falling:bool = false

## How many more physics frames we're immune for, updating on every physics frame.[br][br]
## See [member _immunity_frames_on_hit] for more information on physics frame.
var _immunity_frames_left:int = 0



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #



#region Listeners (i.e. methods that are triggered by a signal/event):

func _ready() -> void:
	super()
	# For connecting _on_hurt_box_area_entered up to when the _hurt_box_area detects an area. 
	_hurt_box_area.area_entered.connect(_on_hurt_box_area_entered)


# Used for detecting input actions (namely when we jump). We don't use this for running since that
# isn't done when the input action is pressed, but instead in _update_velocity_for_run called in
# _physics_process. However, for jump, we only want to do it the moment the action is pressed, hence
# why we use _input for that.
func _input(event:InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_try_jump()


# Overrides to also update relevant properties.
func _physics_process(delta:float) -> void:
	super(delta)
	# If we jumped and are not on the floor, we need to set ourselves as landed, in order to
	# update relevant properties.
	if _jumped and is_on_floor():
		_set_as_landed()
	# If we aren't set as falling, but aren't on the floor and are going downwards, we need to
	# set ourselves as falling, in order to updated relevant properties.
	elif not _falling and not is_on_floor() and velocity.y > 0:
		_set_as_falling()
	_update_hurt_box() # Do this here to update it with velocity.
	_update_immunity_frames() # Do this here since an immunity (physics) frame has passed.


## Called when [member _hurt_box_area] detects a [param area]. [br][br]
## We use this to jump when we get attack an [Enemy].
func _on_hurt_box_area_entered(area:Area2D) -> void:
	var parent := area.get_parent()
	if parent is Enemy:
		_jump()


## Calls [method _jump] or [method _double_jump] if the conditions are right.
func _try_jump() -> void:
	# We only jump if we haven't yet jumped and are on the floor.
	if is_on_floor() and not _jumped:
		_jump()
	# We only double jump if we aren't on the floor, we jumped but we didn't yet double jump.
	elif not is_on_floor() and _jumped and not _double_jumped:
		_double_jump()


## Jumps.
func _jump() -> void:
	_jumped = true 
	velocity.y = -_jump_speed
	await _try_play_animation("jump", true)


## Double jumps.
func _double_jump() -> void:
	_double_jumped = true
	velocity.y = -_jump_speed
	await _try_play_animation("double_jump", true)


# Overridden to set it based on input.
func _update_velocity_for_run() -> void:
	# Basically returns a value between -1 and 1 based on the 'left' and 'right' inputs we give
	# it, allowing is to calcualte the direction we want to walk.
	var walk_direction := Input.get_axis("walk_left", "walk_right")
	velocity.x = walk_direction * _run_speed


# Overridden to reflect our new actions that Entity doesn't have (i.e. falling).
func _update_sprite_animation() -> void:
	if _pause_animations:
		return
	elif is_on_floor() and abs(velocity.x) > 0:
		_try_play_animation("run")
	elif _falling and not is_on_floor():
		_try_play_animation("fall")
	else:
		_try_play_animation("idle")


## Updates [member _hurt_box_area] to only set it to be active if we're falling, otherwise it
## shouldn't be active.
func _update_hurt_box() -> void:
	# monitorable dictates whether the Area2D is detectable, meaning other Area2D (namely other
	# entities' _hit_box_area).
	_hurt_box_area.monitorable = _falling
	# monitoring dictates whether it can detect other Area2D (namely other entities' _hit_box_area)
	# since we need to jump when attacking.
	_hurt_box_area.monitoring = _falling


## Updates [Player] for falling. 
func _set_as_falling() -> void:
	_falling = true
	_sprite.play("fall")


## Updates [Player] for when it lands.
func _set_as_landed() -> void:
	_jumped = false
	_double_jumped = false
	_falling = false
	_sprite.play("idle")


## Allows for ignoring incoming attacks for a given number of physics frames.[br][br]
## See [member _immunity_frames_on_hit] for more information on physics frames.
func _grant_immunity_frames() -> void:
	await get_tree().physics_frame
	_immunity_frames_left = _immunity_frames_on_hit


## Deducts [code]1[/code] from [member _immunity_frames_left].
func _update_immunity_frames() -> void:
	_immunity_frames_left = max(_immunity_frames_left - 1, 0)


# Overridden to return true if the node is an Enemy.
func _can_take_damage(node:Node) -> bool:
	if not node is Enemy:
		return false
	elif _immunity_frames_left > 0:
		return false
	else:
		return true


# Overridden to also grant immunity frames and jump when taking damage.
func _take_damage(entity:Entity) -> void:
	_grant_immunity_frames()
	_jump()
	super(entity)


# Overridden to also disconnect _hurt_box_area to prevent damage after we died.
func _die() -> void:
	_hurt_box_area.area_entered.disconnect(_on_hurt_box_area_entered)
	super()
