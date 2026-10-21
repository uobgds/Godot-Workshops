# ---------------------------------------------------------------------------------------------- #
## For 'attacking' [HitBox]s via 
## [url=https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html]physics 
## collisions[/url]. Optionally can detect them using [signal hit] and [signal killed].
##
## It will essentially 'attack' any [HitBox] it is detected by, with a [member damage] that may
## be used by other scripts when processing the 'attack'.
##
## [br][br]See also [HitBox].
# ---------------------------------------------------------------------------------------------- #


@tool
class_name HurtBox
extends Area2D



# --- Signals --- #
																									
# ----------------------------------------------------------------------------------------------- #


## Emitted whenever a [HitBox] is detected.
signal hit(hit_box:HitBox)

## Emitted whenever a kill is registered (from [method register_kill]), useful for e.g. player
## score.
signal killed



# --- Parameters --- #
																									
# ----------------------------------------------------------------------------------------------- #


## How much hp this will negate (from e.g. [member HealthComponent._health]).
@export var damage:int = 1



# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Sets up collision mask/layers and connects to required signals.
func _ready() -> void:
	# Sets all collision mask/layers to false.
	collision_layer = 0
	collision_mask = 0
	# Sets the HurtBox collision layer to true, so it can be detected by HitBoxes.
	set_collision_layer_value(3, true)
	# Sets the HitBox collision mask to true, so it can detect HitBoxes.
	set_collision_mask_value(2, true)
	# Connects to [signal Area2D.area_entered] so it can detect other [Area2D]s entering it (i.e. other [HitBox]s).
	area_entered.connect(_on_area_entered)


## Called on [signal Area2D.area_entered].
func _on_area_entered(area:Area2D) -> void:
	if area is HitBox:
		var hit_box:HitBox = area
		hit.emit(hit_box)


## Should be called whenever this [HurtBox] has killed something.
func register_kill() -> void:
	killed.emit()
