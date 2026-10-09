Unfortunately since we haven't got much time, it isn't realistic to teach all the basics of Godot during these workshops. However, the good news is that there's a lot of great beginner-friendly material already! So if you're completely new to gamedev and/or Godot, don't worry! Trust me, it's not as hard to get started as you think.

# What Is Godot?
If you're completely unfamiliar with what Godot is, check out its [official introduction page](https://docs.godotengine.org/en/latest/getting_started/introduction/introduction_to_godot.html)! It's basically an open-source program for making both 2D and 3D games and what we're going to be using during these workshops. After properly learning gamedev and how to use Godot, you should be able to make almost any games with it.

# Programming
You will need to know how to program if you want to make games. It's not a problem if you're completely new to programming though!
## Beginners
If you're completely new to Godot, I'd really recommend checking out this [website](https://gdquest.github.io/learn-gdscript/?ref=godot-docs)! It should help you understand the essential basics of programming. If you are still unsure on any of concepts, consider checking out the following videos with great examples for beginners:
- https://www.youtube.com/watch?v=cx_yTggSENU
- https://www.youtube.com/watch?v=f5i9pErfvj8
After these, you should have enough knowledge to get started with gamedev :) Also check out the [GDScript reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) which has examples on how to do everything in GDScript, in case you ever forget!
## Anyone with Experience
If you're already familiar with programming but are new to GDScript, check out its [reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html) page. It should give you a good idea of its syntax, which is very similar to Python and Lua.

# Using Godot
## How to Get It?
You should be able to install Godot on basically any device. The simplest way to get it is from [steam](https://store.steampowered.com/app/404790/Godot_Engine/) or from the [website](https://godotengine.org/download/) (does not auto-update). If you have a tablet, you can get it on [android](https://play.google.com/store/apps/details?id=org.godotengine.editor.v4&hl=en-US&pli=1) or [IOS](https://xogot.com/). It isn't ideal to have none of those devices, but if that's the case then it is possible to borrow a library laptop and run Godot via the [online editor](https://editor.godotengine.org/releases/latest/).
## The Scene Tree
Godot works by using nodes, i.e. objects that can be placed within a scene tree. It's a key concept of Godot that allows for making reusable components, helping us make games more efficiently. If you're unfamiliar, please check out this brief [overview](https://docs.godotengine.org/en/latest/getting_started/introduction/first_look_at_the_editor.html)! The basic idea is that for any part of our games (e.g. the player, any enemy, any levels, etc), we'll make scenes. These scenes are primarily made up of nodes. Then we'll combine all our scenes together to construct our game (since scenes are also just nodes). E.g. we can construct our level using the player scene, the enemy scenes and the environment scenes. We can easily reuse scenes (like e.g. the player) which makes this really powerful!
## The Interface
If you're confused on how to use Godot's interface, check out this [guide](https://docs.godotengine.org/en/latest/getting_started/introduction/first_look_at_the_editor.html)! The basic idea is that most of your game will be taking place in the 'Scene' window on the left. You can add your nodes to the scene by right-clicking in the window. It might be pretty intimidating to see how many nodes Godot has, but you won't need to understand or use most of them so don't worry! Check out [this resource](essential_classes.md) for the nodes you'll likely be using.

# The Documentation
The best way to figure out how to do everything is using the Godot documentation! If you're unsure about something, try to find the relevant class' documentation within the editor (CTRL-click the name of the class or search it using F1 or Help -> Search Help). A lot of classes' documentation have linked tutorials in them! You can also search online what you want to do with 'Godot' and you might be able to find a guide on it (e.g. 'Godot input')

# What Next?
Just start making your first game! The best way to learn gamedev is by just doing, after all. You can start with a basic version of the platformer [here](basic_platformer.md).