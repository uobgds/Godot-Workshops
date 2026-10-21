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


## Called on [signal Area2D.area_entered].
func _on_area_entered(area:Area2D) -> void:
	if area is HurtBox:
		var hurt_box:HurtBox = area
		hit.emit(hurt_box)
