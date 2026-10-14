# ---------------------------------------------------------------------------------------------- #
## An abstract base class for player/enemies, with common logic. 
##
## An abstract class is a class that can't be instantiated. Instead, it can only be extended by
## other classes (which then can be instantiated given they aren't also abstract). This class is
## abstract since it doesn't make sense to instantiate an [Entity] by itself, it should be instead
## extended by another class (e.g. [Player] or [Enemy]).
## 
## [br][br]It extends [CharacterBody2D] because of how convenient it is to move using 
## [member CharacterBody2D.velocity] and [method CharacterBody2D.move_and_slide], as well as its
## other methods like [method CharacterBody2D.is_on_floor].
# ---------------------------------------------------------------------------------------------- #


@warning_ignore_start("unused_private_class_variable")
@abstract # See documentation description (also above) for what an abstract class is and why should be one.
class_name Entity
extends CharacterBody2D # See documentation description (also above) for why we extend this class.




# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


#region Parameters (i.e. properties we can edit in the editor to change behaviour):

@warning_ignore("unused_private_class_variable") # For ignoring a 'wrong' editor warning, since it is infact used by inherited classes.
## How much to move per second whilst running.
@export var _run_speed:float = 100

## How much to change [member CharacterBody2D.velocity.y] per second.
@export var _gravity_acceleration:float = 10

## The maximum value of [member CharacterBody2D.velocity.y], to prevent infinite acceleration
## from gravity.
@export var _terminal_speed:float = 200

## How much [member damage] can be taken before death.
@export var _health:int = 1

## How much to take from [member _health] when attacking.
@export var damage:int = 1

#endregion


#region Dependencies (i.e. required properties that must be there):

## Reference to the [Entity]'s [AnimatedSprite2D]. 
## For more information on the '%', check 
## [url=https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html]this guide[/url].
@onready var  _sprite:AnimatedSprite2D = %AnimatedSprite2D

## Reference to the [Entity]'s [Area2D] that will be used for detecting other [member _hurt_box_area]
## and take damage from them. [br][br]
## For more information on [Area2D], check 
## [url=https://docs.godotengine.org/en/stable/tutorials/physics/using_area_2d.html]this guide[/url].[br][br]
## [color=khaki][b]WARNING:[/b] This is set to '%HitBoxArea', so it means there needs to be a 
## scene-unique node set with the name 'HitBoxArea' and 'Access as Unique name' set. For information
## on scene-unique nodes, check 
## [url=https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html]this guide[/url].[/color][br][br]
@onready var _hit_box_area:Area2D = %HitBoxArea

 # For ignoring a 'wrong' editor warning, since it is infact used by inherited classes.
## Reference to the [Entity]'s [Area2D] that will be used by another [Entity]'s [member _hit_box_area]
## for applying [member damage]. [br][br]
## For more information on [Area2D], check 
## [url=https://docs.godotengine.org/en/stable/tutorials/physics/using_area_2d.html]this guide[/url].[br][br]
## [color=khaki][b]WARNING:[/b]This is set to '%HurtBoxArea', so it means there needs to be a 
## scene-unique node set with the name 'HurtBoxArea' and 'Access as Unique name' set. For information
## on scene-unique nodes, check 
## [url=https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html]this guide[/url].[/color][br][br]
@onready var _hurt_box_area:Area2D = %HurtBoxArea
#endregion


## We use this to prevent updating of animations, in case we want to play an animation which won't
## get overridden.[br][br]
## For example, [method Player._update_sprite_animation] will constantly update [member _sprite]'s
## current animation. In [method _take_damage], we want to play the hurt animation and prevent
## the updating from within [method Player._update_sprite_animation]. Therefore, we set this
## to [code]true[/code] while the hurt animation plays (within [method _try_play_animation]), to
## ensure the animation doesn't get overridden.
var _pause_animations:bool = false

## We use this to prevent logic after this [Entity] dies, but before it is deleted (since we still 
## need to wait for any animations to finish).
var _died:bool = false



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


#region Listeners (i.e. methods that are triggered by a signal/event):

func _ready() -> void:
	# Connects the _hit_box_area's signal to call _on_hit_box_area_entered when it detects
	# an area.
	_hit_box_area.area_entered.connect(_on_hit_box_area_entered)


# We do any framerate-dependent logic here.
func _process(_delta: float) -> void:
	# We update animation and direction here since if we do it in _physics_process, it may change
	# in-between frames which might look jittery. It probably isn't too noticeable so this
	# likely isn't needed.
	_update_sprite_animation() 
	_update_sprite_direction()


# We do any _physics_process-dependent logic here (e.g. move_and_slide and updating velocity).
func _physics_process(_delta:float) -> void:
	_do_movement()


## Called when [member _hit_box] detects an [param area]. We use it to [method _take_damage] if
## the [param area] belongs to a node that [method _can_take_damage].
func _on_hit_box_area_entered(area:Area2D) -> void:
	var parent := area.get_parent()
	if _can_take_damage(parent):
		_take_damage(parent as Entity)

#endregion


## Updates and applies [member CharacterBody2D.velocity].
func _do_movement() -> void:
	_update_velocity_for_gravity()
	# If died, we don't want to change velocity for running.
	if not _died: 
		_update_velocity_for_run()
	move_and_slide()


## Applies [member _run_speed] to [member CharacterBody2D.velocity].[br][br]
##
## An abstract function is a function of an abstract class which isn't yet defined and needs to be
## defined by any inheriting class (given that it's not also abstract). If you're unsure with what
## an abstract class is, check this class's documentation description. [br][br]
##
## This method is abstract, since each inheriting class should define the method differently. E.g. 
## the [Player] will update it based on the user's input, but the [Slime] will do it based on if it 
## collided with something, since it changes direction on collision.
@abstract func _update_velocity_for_run() -> void


## Applies [member _gravity_acceleration] and [member _terminal_speed] to [member CharacterBody2D.velocity].
func _update_velocity_for_gravity() -> void:
	velocity.y = minf(velocity.y + _gravity_acceleration, _terminal_speed)


## Returns whether this [Entity] can take damage from [param node].[br][br]
##
## An abstract function is a function of an abstract class which isn't yet defined and needs to be
## defined by any inheriting class (given that it's not also abstract). If you're unsure with what
## an abstract class is, check this class's documentation description. [br][br]
##
## This method is abstract, since each inheriting class should define the method differently. E.g. 
## the [Player] will return [code]true[/code] only if [param node] is an [Enemy], but [Enemy] will
## return [code]true[/code] only if [param node] is a [Player].
@abstract func _can_take_damage(node:Node) -> bool


## Applies [member damage] of [param entity] to [member _health] and checks for whether this [Entity]
## died also.
func _take_damage(entity:Entity) -> void:
	_health = maxi(0, _health - entity.damage)
	_try_play_animation("hurt", true)
	if _health <= 0: # Checks if should die. If so, dies.
		_die()


## Updates the current animation that [member _sprite] is playing, based on the properties of the
## [Entity].
func _update_sprite_animation() -> void:
	if _pause_animations:
		return
	# If the [Entity] is on the ground and its horizontal velocity isn't 0, then it means it is
	# running and we need to play the running animation.
	elif is_on_floor() and abs(velocity.x) > 0:
		_try_play_animation("run")


## Updates [member _sprite.flip_h], based on [member velocity], since when we move to the left, we
## need to flip [member _sprite].
func _update_sprite_direction() -> void:
	if velocity.x == 0:
		return
	else:
		_sprite.flip_h = velocity.x < 0


## Plays [param animation_name] using [member _sprite] if it isn't already playing, and then waits
## for it to complete.
## If [param pause_other_animations] is [code]true[/code], then sets [member _pause_animations] to
## [code]true[/code] whilst playing [param animation_name].
## See [method _wait_for_animation] for more information on waiting for animations.
func _try_play_animation(animation_name:String, pause_other_animations:bool = false) -> void:
	if not _sprite.animation == animation_name:
		_sprite.play(animation_name)
		if pause_other_animations:
			_pause_animations = true
		await _wait_for_animation()
		if pause_other_animations:
			_pause_animations = false


## Waits for the completion of [member _sprite]'s current animation, if it's playing. If the current
## animation is looping, we only wait for the current loop to finish. [br][br]
## To use, you need to include await before calling this function. E.g. 
## [code]await _wait_for_animation()[/code].
func _wait_for_animation() -> void:
	if _sprite.is_playing():
		if _sprite.sprite_frames.get_animation_loop(_sprite.animation):
			await _sprite.animation_changed
		else:
			await _sprite.animation_finished



## Makes this [Entity] die, disabling logic and deleting after animaions.
func _die() -> void:
	_died = true
	velocity.x = 0 # Prevent moving after death.
	_pause_animations = true # Prevents all animation updates.
	 # Prevents receiving damage via _on_hit_box_area_entered.
	_hit_box_area.area_entered.disconnect(_on_hit_box_area_entered)
	# If there's an animation still playing, we need to wait for it.
	await _wait_for_animation()
	queue_free()
