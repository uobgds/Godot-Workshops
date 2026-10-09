These are some good practices that you should be doing in all your projects! They will help you code more efficiently, saving you a lot of time in the future (from e.g. bug fixing, understanding old code, etc).

# Coding Style Consistency
Coding style refers to the way you structure your scripts, how you name your variables, functions, parameters, etc. You might think it's not that important, but it actually makes a huge difference!

For example, the following code is pretty ambiguous and inconsistent:
```GDScript
func _hitbox_enter(A):
	var Par A.get_parent()
	if _dmging(Par):
		_Damage(Par)
	if Par is Coin:
		_PickUP(Par)
```
If you take the time to go through it line-by-line, you could probably figure it out. That time might seem insignificant, but if all your scripts are like that, it starts to add up. Consider the following example instead:
```GDScript
func _on_hit_box_area_entered(area:Area2D) -> void:
	var parent:Node = area.get_parent()
	if _can_take_damage(parent):
		_take_damage(parent)
	if parent is Coin:
		_pick_up_coin(parent)
```
All we did was change the way we named everything, but it's so much easier to immediately know what's going on. The code is so much more readable and clear. The time it takes to code like this is hardly any different, but it can save so much future time! It's especially important when working with others, since reading other people's code can get very confusing and time-consuming. You can choose any coding style you like, but make sure to keep it consistent. I'd recommend making everything as 'verbose' as possible (i.e. super explicitly clear by avoiding abbreviations). Check out the [official Godot styling guide]([https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html), which can be a great starting point!


# Functions
This is so incredibly important and can greatly increase your coding efficiency. The general rule is to keep functions as small as possible, focused on a single/specific thing. I'd recommend you try to split functions as much as possible, even if you don't reuse any of the individual functions. It allows you to naturally break down problems into smaller, more manageable parts, as well as increases readability and debugability!

For example, the following function is very big and quite unreadable:
```GDScript
func _physics_process(delta:float) -> void:
	_current_roll_cooldown = maxf(0, _current_roll_cooldown - delta)
	velocity.y = minf(velocity.y + _gravity_acceleration, _terminal_speed)
	if not _died and not _rolling:
		var walk_direction := Input.get_axis("walk_left", "walk_right")
		velocity.x = walk_direction * _walk_speed
		if velocity.x == 0:
			return
		else:
			_sprite.flip_h = velocity.x < 0
	move_and_slide()
	if _pause_animations:
		return
	elif abs(velocity.x) > 0 and not _sprite.animation == "walk":
		_sprite.play("walk")
	elif velocity.x == 0 and not _sprite.animation == "idle":
		_sprite.play("idle")
	if velocity.y > 0 and not _hurt_box_area.monitorable:
		_hurt_box_area.monitorable = true
	elif velocity.y <= 0 and _hurt_box_area.monitorable:
		_hurt_box_area.monitorable = false
	for enemy:Enemy in _enemy_immunity_frames_map.keys():
		_enemy_immunity_frames_map[enemy] -= 1
		if _enemy_immunity_frames_map[enemy] <= 0:
			_enemy_immunity_frames_map.erase(enemy)
```
It isn't straightforward to figure out what's going on which can be a huge problem if you're working with others or just forget how your old code works. You could add comments which might help, but consider this example instead:
```GDScript
func _physics_process(delta:float) -> void:
	_update_cooldowns(delta)
	_do_movement()
	_update_hurt_box()
	_update_enemy_immunity_frames()
	
func _do_movement() -> void:
	_update_velocity_for_gravity()
	if not _died:
		_update_velocity_for_walk()
	move_and_slide()
	_update_sprite_animation()
```
Now suddenly it's incredibly easy to understand, without using any comments! Code like this is 100x easier and quicker to debug, so trust me when I say it's worth it.


# Static Typing
It may sound complicated, but it's just the idea of telling Godot what types of variables to expect. Then when you accidentally write bad code that breaks what Godot expects, it'll tell you before it turns into an error. The best way to understand how to use static typing is by first looking at the opposite, known as duck typing. This is probably the most effective way to easily code more efficiently.

## What Is Duck-Typing?
In GDScript (and other similar languages like Python), you can declare `var`, `const` and function parameters without giving them types. For example:
```GDScript
func _ready():
	var test_variable = "hello"
	test_function(test)

func test_function(test_parameter):
	print(test_parameter)
```
This is what duck-typing is, not specifying types. Next we'll explore why it's bad!

### Why Duck-Typing Is Bad
For example, we can define the following basic function as follows:
```GDScript
func get_bigger_num(num1, num2):
	return max(num1, num2)
```
We can then call that function like so:
```GDScript
# For anyone unfamiliar with _ready, it just runs when the Node is2 first 'ready' (more details later).
func _ready():
	var num1 = 5
	var num2 = 8
	var bigger_num = get_bigger_num(num1, num2)
	print(bigger_num)
```
Which should run just fin without any warning/errors. However, we can also do the following:
```GDScript
func _ready():
	print(get_bigger_num(5, "test"))
```
This won't give any warnings/errors within the editor, but when run, it will produce an error because you can't call `max(5, "test")`. Of course, this is quite basic and pretty easy to avoid, but in more complex situations, it becomes a lot more of a problem. We can see this using another example:
```GDScript
func _ready():
	# get_some_node could be some random function we're assuming returns a Node2D
	var some_node = get_some_node() 
	print(some_node.position)
```
 If `get_some_node` does indeed return a `Node2D`, this will work perfectly fine. However, let's say you aren't familiar with how `get_some_node` works because it was made by another programmer on your team (e.g. in a game jam), or perhaps it was made by you but you forgot about it. This means you'll need to check `get_some_node` to make sure it's a `Node2D`, to prevent any errors when run. It may seem pretty insignificant, but it's going to end up adding up and increasing the development curve, when there are hundreds of functions just like `get_some_node`. That's even ignoring the fact that you might check `get_some_node` wrong, or perhaps it may return different types based on different situations. There's also the fact that you might just mistype the property name, which will give no warnings/errors until the line is run. This is especially common when working with custom types. For example, let's say we have a function `get_custom_node` that returns the following type:
 ```GDScript
 class CustomNode:
	 extends Node
	 var custom_property = "test"
 ```
If we try:
```GDScript
var custom_node = get_custom_node()
print(custom_node.custom_property) # Works
print(custom_node.other_custom_property) # Error
```
No warnings/errors will be shown until both lines are run. There are so many other reasons why duck-typing is inefficient, but hopefully you are convinced by now.

## How Static Typing Solves These Issues
Now let's look at how static-typing solves all these issues. When we always specify types and configure Godot to give warnings/errors for duck-typing, all the previous examples are no longer problems anymore. For example, with the first example, we can use static typing like so:
```GDScript
func get_bigger_num(num1:int, num2:int) -> int:
	return maxi(num1, num2)

func _ready() -> void:
	var num1 := 5
	var num2 := 8
	var bigger_num := get_bigger_num(num1, num2) 
	print(bigger_num)
```
I'll explain how to actually use static typing in the next section (i.e. how to use `:= and :`). If we attempt to use the wrong types:
```func _ready() -> void:
print(get_bigger_num(1, "test))
```
We will get an editor error that doesn't let us run this! This will also work for the other examples. Another side-effect from static typing is the fact that it allows for auto completion within the editor, so you don't even have to remember all the property/method names of the types your working with. This is especially useful for any custom types! In order to prevent the majority of errors from duck-typing, you'll need to turn on some GDScript debug warnings in project settings (which I'll explain shortly).

## How to Use Static Typing
All `var` and `const` can be typed using `:` and `func` return values can be typed using `->`. For example:
```GDScript
var damage:float = 10.5
const MOVE_SPEED:float = 50.0
func sum(a:float = 0.0, b:float = 0.0) -> float:
	return a + b
```
Note that the convention for typing using `:` is to leave no space between `var`/`const` name and `:`, but leave a space between the `:` and type, like so:
```GDScript
var damage: float = 10.5
const MOVE_SPEED: float = 50.0
func sum(a: float = 0.0, b: float = 0.0) -> float:
	return a + b
```
But I think it looks it looks ugly so I remove the space. You can do it either way, just try to stay consistent (more about this later). You can also infer types with `:=` which can be faster and still allows for the benefits of static typing. 
```GDScript
var damage := 10.5
# Make sure to add the .0 for any floats, otherwise it'll be inferred as an int.
const MOVE_SPEED := 50.0 
func sum(a := 0.0, b := 0.0) -> float:
	return a + b
func other() -> void: # Use void for specifying no return type/value.
	return
```
But this has the potential to make your code less readable, so be a bit careful about this (more about this later as well). You also should always define any custom script's `class_name` so it can also use static typing. For example:
```GDScript
class_name CustomNode # Define the 'type' here!
extends Node
...
```
You also should specify types of `Array` where possible!
```GDScript
var scores: Array[int] = [10, 20, 30]
var vehicles: Array[Node] = [$Car, $Plane] # More about $ notation later.
var items: Array[Item] = [Item.new()]
var array_of_arrays: Array[Array] = [[], []]
# var arrays: Array[Array[int]] -- not supported unfortunately

for score:int in scores:
	# the score is actually automatically typed as `int`

for score in scores:
	# is the exact same as the above for loop, but could be less readable

# The following would be errors:
scores += vehicles
var s: String = scores[0]
scores[0] = "lots"
```
Also for `Dictionary`:
```GDScript
var fruit_costs: Dictionary[String, int] = { "apple": 5, "orange": 10 }
var vehicles: Dictionary[String, Node] = { "car": $Car, "plane": $Plane }
var item_tiles: Dictionary[Vector2i, Item] = { Vector2i(0, 0): Item.new(), Vector2i(0, 1): Item.new() }
var dictionary_of_dictionaries: Dictionary[String, Dictionary] = { { } }
# var dicts: Dictionary[String, Dictionary[String, int]] -- also disallowed

for fruit in fruit_costs:
	# `fruit` has type `String`

# The following would be errors:
fruit_costs["pear"] += vehicles
var s: String = fruit_costs["apple"]
fruit_costs["orange"] = "lots"
```
To make sure the Godot editor gives warnings/errors within the editor for any duck-typing (at least in most situations), you'll need to change the following settings. Go to Project -> Project Settings -> General -> Debug (toggle advanced settings) -> GDScript and update the following:
- Untyped Declaration: Error
- Unsafe Property Access: Error
- Unsafe Method Access: Error
- Unsafe Cast: Warn
- Unsafe Call Argument: Error

The [official Godot guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html) is a good place to find out more, especially on typecasting and 'unsafe operations'.
