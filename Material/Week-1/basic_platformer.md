Let's start making our platformer, with a basic version first! I'd recommend you experiment to try figure things out. If you're unsure on where to start, check out the [essential classes guide](essential_classes.md) for some very useful nodes you'll likely be needing. If you're struggling, you might find it useful to check out this [guide](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html). I'm currently working on a guide for implementing the basic version of the platformer, so in the next few days this file should be updated with it.

# Before you start…

## Template Project
You can find the template project for the platformer [here](/Examples/Basic-Platformer-Template/). It will have all the assets you'll need already organised, which is pretty helpful to get started with!

## Features
For now, we're going to keep it simple with the following features (ordered roughly by difficulty):
- Player:
	- Move left and right.
	- Jump.
	- Double jump.
	- Take damage, jumping when it does.
	- Die when 0 health.
	- Attack by jumping on enemies, giving another jump when it does.
- Enemy:
	- Move continuously in one direction.
	- Change direction when colliding with a wall.
	- Take damage if player jumps on it.
	- Die when 0 health.
	- Attack when touches player.
- Basic level tile map (not a big focus though).

We'll be using the assets within this repository, made by PixelFrog. Check the [credits and license file](/Assets/CREDITS_AND_LICENSE.txt) for more information, if you want to use it in another project outside this workshop.

# Helpful Tips
- Start with the simpler features first!
- Try to use all the [practices I mentioned earlier](good_practices.md)! It'll make debugging a lot easier.
- Using `CharacterBody2D` will make your life a lot easier since you can use `velocity` for moving left and right, as well as jumping with gravity. It might be useful to check out [this guide on collisions/physics](https://docs.godotengine.org/en/stable/tutorials/physics/index.html).
- You can set your own input actions within Project Settings -> Input Map -> Add New Action. You'll need to do this for all the different inputs like moving left and right and jumping! You'll then be able to access these actions within `Input` singleton (accessed by just using the class without an instance) and `InputEvent`.
- You'll need to set up the 'ground' for implementing gravity, otherwise your character will keep falling forever. One way to do this by setting up the tile map with collisions using `TileMapLayer` (check [this useful guide](https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html)).
- I'd recommend setting up a bunch of variables/conditions for keeping track of different things the player does. E.g. `_jumped` for when the player has jumped, which is then reset when the player is on the ground (which can be checked using `CharacterBody2D.is_on_floor`). You can then update all these different variables/conditions within `_physics_process`.
- For sprite animations, the easiest way to do it is by adding a child `AnimatedSprite2D` node and changing the animation being played using `AnimatedSprite2D.play` whenever needed.
- I'd also recommend to try separate animations from logic. For example, in `_process`, separate from the physics code, you can play the running animation whenever `not velocity.x == 0`.
- For combat, I'd recommend using `Area2D`. You can use one for the hit boxes, i.e. for detecting attacks and taking damage from them. Then another can be used for hurt boxes which are detected by the hit boxes for determining when to take damage.

# Guide
I'm still working on this, but I should complete it soon...