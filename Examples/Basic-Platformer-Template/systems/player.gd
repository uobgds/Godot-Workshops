# ---------------------------------------------------------------------------------------------- #
## This script will be used for implementing all the player's logic here!
##
## The features it needs to have: [br]
## - Moving left and right using input [br]
## - Jumping using input [br]
## - Double-jumping using input [br]
## - Taking damage from enemies, jumping when it does [br]
## - Dies when on 0 health [br]
## - Can attack by jumping on enemies, giving another jump when it does
# ---------------------------------------------------------------------------------------------- #


# Define class_name and what it extends here!



# --- Properties --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Add your properties here!




# --- Methods --- #
																									
# ----------------------------------------------------------------------------------------------- #


# Any code here will run at the start of the game (when this node is 'ready').
func _ready() -> void:
	pass


# This can be used for detecting inputs and making the player do the appropriate things with them!
func _input(event:InputEvent) -> void:
	pass


# This is called every physics frame/tick, i.e. consistently and independent of framerate unlike
# _process, making it ideal for physics-related things.
#
# You'll need this for a lot of CharacterBody2D's functionality. E.g. move_and_slide which updates
# position based on velocity should be called from here (or in another function which was initially
# called here. You can check any documentation on methods to check if they should be called in here.
func _physics_process(delta:float) -> void:
	pass


# This is called once every frame. You should ideally call any visual things here, like manually
# updating position. Sometimes if you update stuff in-between frames, it makes stuff look jittery.
func _process(delta: float) -> void:
	pass
