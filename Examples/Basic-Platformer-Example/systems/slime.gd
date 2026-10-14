# ---------------------------------------------------------------------------------------------- #
## Implements basic behaviour for a slime.
# ---------------------------------------------------------------------------------------------- #


class_name Slime
extends Enemy


## Used to detect when about to collide with a wall, so it can change direction.
@onready var _ray_cast:RayCast2D = %RayCast2D


func _ready() -> void:
	super()
	velocity.x = _run_speed # Since we want to immediately start running when the level starts.


# Overridden to change direction of velocity if about to collide.
func _update_velocity_for_run() -> void:
	# get_collider() returns null if no collision, or a non-null if a collision was detected.
	# Therefore if it isn't null, we need to change direction.
	if not _ray_cast.get_collider() == null:
		velocity.x *= -1
		_ray_cast.target_position.x *= -1


# Overridden to reverse the sprite direction logic since this sprite's texture is flipped for some 
# reason.
func _update_sprite_direction() -> void:
	if velocity.x == 0:
		return
	else:
		_sprite.flip_h = velocity.x > 0
