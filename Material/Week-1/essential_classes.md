This is a guide on the classes you'll be using to make the majority of your platformer! For each class, I've made a brief overview and guide on how to use it. However, it doesn't have everything, so make sure to also check out the linked documentation! Every function can be included within your scripts that extend that node and will automatically be called at the appropriate time (indicated by a blue connection symbol within the editor).



# [Node](https://docs.godotengine.org/en/stable/classes/class_node.html#node)
>This is the base class that all other nodes will extend. Anything that you can place in the scene tree extends this node. It has a lot of very useful functions and properties though, which all classes that extend it (i.e. every other type of node) will also have.

## [`_ready`](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-private-method-ready)
>Heavily oversimplified, this is called once when the game starts. So any code that you want to run once at the start of the game, put it in here. It isn't actually as simple as that though.

### When It Actually Runs
It is run when the node completes its setup, i.e. when it 'enters' the scene tree. Basically, at the start of the game, the scene tree needs to be setup. What Godot does is goes through each node within the running scene, sets it up and then when it's completed setting up, it adds it to the scene tree. When it is added to the tree,`_ready` is called (hence why it 'enters' the tree). If the node has any children, it will make sure all its children have completed setting up before it is added to the scene tree. Therefore when `_ready` is called, any child nodes should also be 'ready' and have its `_ready` functions called. However, this means its parent's nodes won't be set up, so you'll have to wait for them to be setup if you want to change any scene-tree-dependent properties (e.g. a `Node2D`'s position).
### Example
```GDScript
func _ready() -> void:
	# You can add whatever code you want to run when the node finishes
	# it's setup (i.e. when it 'enters' the scene tree).
	print("This node is now ready!")

```

## [`_process(delta:float)`](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-private-method-process)
>After the node enters the scene tree (i.e. when `_ready` is called), this function will be called once every single frame, based on FPS, so it'll likely be called hundreds of times a second. 
### What Is `delta`?
`delta` is how many seconds have passed since `_process` was called (i.e. time since last frame). It will likely be a very small number and lets you do time-dependent actions like moving at a constant speed. If you don't use `delta`, then your code may be dependent on frame rate (which usually isn't good).
### Example
```GDScript
extends Node2D # Required for position (in a 2D scene)!

const SPEED:float = 100 # Used for our movement code.

# You will want to use delta for any code that shouldn't be frame-specific.
# E.g. if you want to move at a constant speed, you'll need to find distance
# using delta.
func _process(delta:float) -> void:
	
	# Assume get_target_global_position() is a method that returns a Vector2
	# with the target we want this Node2D to move towards.
	var target_global_position:Vector2 = get_target_global_position()
	
	# Distance is calculated (using distance = speed * time where delta is time).
	# If we didn't use delta here,
	var distance:float = SPEED * delta
	
	# We can then find the direction to move using Vector2's methods.
	var direction:Vector2 = global_position.direction_to(target_global_position)
	
	# Then we can find how much to move.
	var displacement:Vector2 = distance * direction
	
	# Finally we move this Node2D using displacement.
	global_position += displacement
	
	# NOTE: This may result in actually overshooting the target position since
	# we assume the distance to target_global_position is always more than
	# speed, but in reality, it will become less when the Node2D gets closer.
	# Therefore, when the distance to target_global_position is less than
	# SPEED, we should immediately just move to target_global_position.
```

## [`_physics_process(delta:float)`](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-private-method-physics-process)
>Similar to `_process`, but isn't called every frame but instead on every physics tick (which is a lot more consistent).

### When to Use `_physics_process` Instead Of `_process`?
In general, you should use `_process` for most things, especially for directly updating position. If you update position within `_physics_process`, it may look jittery since it isn't on each frame. If you have any physics logic like `move_and_slide`, then it makes sense to use this instead. Any functions that are suitable to be used in `_physics_process` will mention it 

## [`_input(event:InputEvent)`](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-private-method-input)
>Called whenever there's any input detected by the game (e.g. mouse position update, keyboard press, input action detected, etc). The type/data of input is contained within `event`. You can also use `Input` to detect whether something is being pressed or updated directly. Check out relevant the [examples](https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html).
### Getting Mouse Position
If you're using a `Node2D`, you can get the current mouse position using `get_global_mouse_position` instead!
### Logic In `_input`
Be careful with putting any game logic inside `_input` since it is only called whenever there's an input. So if there's no input, it won't be called. Instead, put the logic in `_process`. You can use `_input` to update variables (e.g. update `target_position`).



# [Node2D](https://docs.godotengine.org/en/stable/classes/class_node2d.html)
> This is any node that also has a 2D position! 
## Difference Between `position` And `global_position`
`position` is the local position of the node. This means it is relative to its parent's `position`. It can be set in the editor, unlike `global_position` which can't. `global_position` refers to the actual position of the `Node2D`, ignoring relativity to the parent. So if you want to change a `Node2D`'s position independently of its parent (which you'll probably want to do often), make sure to use `global_position`. I'd also recommend adding  `global` to any non-relative position with to avoid confusing (e.g. `target_global_position`).
### Using Mouse Position
You don't need to use `_input` for getting the mouse position. Instead, you can just use `get_global_mouse_position` which all `Node2D` (and `CanvasItem`) has.


# [Sprite2D](https://docs.godotengine.org/en/stable/classes/class_sprite2d.html#sprite2d)
> A `Node2D` that can also have a texture. If you want to check whether positions are being updated whilst the game is running, this can be very useful! It has a bunch of other useful properties too, like `flip_h`, `flip_v`, `centered`, etc.



# [AnimatedSprite2D](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html)
>A `Node2D` similar to `Sprite2D`, but can showcase animations using `SpriteFrames`. Check out [this guide](https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html) for help on 2D animation!



# [CollisionObject2D](https://docs.godotengine.org/en/stable/classes/class_collisionobject2d.html#class-collisionobject2d)
> An abstract class for any `Node2D` that uses [collision layers/masks](https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html#collision-layers-and-masks). An abstract class is just a class that can't be instantiated, only extended. This means that you can't make a `CollisionObject2D` node, but can make any of the nodes it's inherited by (e.g. `Area2D`). Check out this [guide on physics](https://docs.godotengine.org/en/stable/tutorials/physics/index.html), which mostly uses `CollisionObject2D`. 



# [Area2D](https://docs.godotengine.org/en/stable/classes/class_area2d.html#class-area2d)
>A `CollisionObject2D` that can easily detect other `CollisionObject2D` that overlap with it. It's useful for detecting collisions for a scenario where physics aren't required. Requires at least one child `CollisionShape2D`/`CollisionPolygon2D` for defining the detecting area. Check out its [guide](https://docs.godotengine.org/en/stable/tutorials/physics/using_area_2d.html) on how to use it!


# [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
>A `CollisionObject2D` that allows for very straightforward movement logic. This is what your player and a lot of enemy classes might utilise! The most useful function is the `move_and_slide`, which can be used within `_physics_process` for moving a player. Check out its [guide](on how to use it) on how to use it!


``