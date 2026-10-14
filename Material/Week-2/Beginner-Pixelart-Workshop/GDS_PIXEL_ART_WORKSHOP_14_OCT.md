# Tutorial Beginner Pixel Art (14 Oct 2026)

Written by Irfan Satria (UoB Game Development Society)

## Welcome to the GDS Pixel Art workshop! By the end if this workshop hopefully you will learn how to make basic pixel art assets for your own game.  

<img src="images/GnomeRun.gif" alt="gnome run animation" width="100">

Structure:

1. [Introduction](#intro)
   1. [What is Pixel Art?](#what-is-pixel-art)
   2. [Why Learn Pixel Art?](#why-learn-pixel-art)
   3. [Getting Started with Pixel Art](#getting-started-with-pixel-art)
3. [Learning about the tool (Piskel)](#learning=about-the-tool)
   1. [Making basic shapes and colouring](#creating-and-colouring-a-basic-shape-simple-ball)
   2. [Making a simple animation](#simple-bounce-animations)
   3. Exporting sprite  
4. Making a platforming character (using a base)  
   1. Importing a base spritesheet  
   2. Creating a custom character from a base

## INTRO

### What is Pixel Art?
Pixel art is a style of art born in the early days of computer graphics. 
Since computers back then can only render out a limited number of pixels at a time, every single pixel matters in creating the desired image!
It’s called pixel art because every placed pixel is a deliberate choice from you, the artist!

---

### Why Learn pixel Art?
Pixel art is a very popular medium for game art because it has several big advantages:

First, It is very accessible and does not require advanced tools. Born from technological limitations, pixel art were literally stuff drawn on grid paper before being digitized. It’s what devs did back when games development was still at its early stage. 

<img src="images/image19.png" alt="Image 1" width="300">

Second, It is simple and easy to learn, and scales well with your skill. a coherent image can be made using a minimal amount of pixels and colours, which is pretty easy to do. For example, the original MegaMan sprite is only 16 pixels tall with 5 colours and can be easily replicated with minimal skill..

<img src="images/image16.png" alt="Image 2" width="400">

But with more advanced techniques, shading, etc.. and bigger canvas, you can make more detailed sprites.

Lastly, It is easy to integrate into games. Pixel art file size is very SMALL. It’s perfect for small games that will run on any hardware using any game engine.

<img src="images/image35.png" alt="Image 6" width="100">

---

### Getting Started with Pixel Art

There are probably only two things in mind if you’re going to start a project,

***The first one is sprite size \-\> your game’s target style***

In retro games/ pixel art games, dimension plays a very big role because it is based on how many pixels the hardware can render every frame. This is called a “native” resolution. The more pixels there are, the more detailed your piece will be.


<div align="left">
  <img src="images/image27.png" alt="Image 3" width="500">
  <br>
  <sub>Different hardware rendering resolutions. From <i>Pixel Logic</i> by Michael Azzi.</sub>
</div>

<br>

Obviously nowadays we are not constrained by small resolutions as HD has become the standard, and with game engines like Godot you are able to set the resolution of the game yourself. Pixel art has become more of a stylistic choice nowadays rather than necessity, unless you are using something like Pico-8 or developing for an old console.

My game Fish Greaves, was built for the original gameboy hardware from 1989\. I had to work with the hard limits of the gameboy to actually make the game, such as the cramped 160x144 native resolution and a tiny 4-colour palette. The player character Mr Fishy is a 32x32 sprite, which looks huge on the gameboy’s screen.

<img src="images/image6.png" alt="Image 4" width="200"> <img src="images/image34.png" alt="Image 5" width="200">

Even if you’re developing a modern game, if you’re intentionally going for a retro aesthetic it’s very important to know what console “style” you’re emulating.

For example, games like Mina the Hollower target the Gameboy Colour style, therefore it deliberately uses a limited amount of pixels, and limited colours. In fact, Mina the Hollower uses a similar native resolution to a gameboy colour (160x144), but modified to 16:9 (256 pixels wide by 144 pixels tall). So in a way, it is a GBC-styled modern game.

<img src="images/image13.png" alt="Image 7" width="300">

More “detailed” pixel art games like Sonic Mania has the resolution 424x240, which is a popular 16:9 “approximation” of 240p graphics consoles style in the 16 bit era, such as the Sega Genesis (320x240) and Super Nintendo (256x240) (and by extension the Saturn and PS1). 	Sonic’s sprite in these games is 39 pixels tall.

<img src="images/image45.png" alt="Image 8" width="300">

Another example is “Goodboy Galaxy”, a modern game from 2023 designed for the Gameboy Advance, with a native resolution of 240x160 pixels. The player character is 32 pixels tall.

<img src="images/image7.png" alt="Image 9" width="300">

For games built for PC and modern consoles (Which is likely what you'll be doing), most Godot guides and tutorials will recommend you to go with 480x270. 
It is a very popular 16:9 resolution that scales nicely to 1080p and grants you a sufficiently big workspace to add a lot of elements to your game.
TMNT: Shredder's Revenge and many other modern pixel games use this resolution.

<img src="images/tmnt.jpg" alt="tmnt" width="300">

***And then the second one is the tool.***

I’ve mentioned before that pixel art can be done in many programs, even MS Paint if you’d like. While there is hardly a wrong choice in which tool to pick for doing pixel art there are dedicated pixel art editors that make our life much easier.

Open Source

- Piskel  
- LibreSprite (a fork of old version of Aseprite)  
- Aseprite (compile yourself, paid precompiled version available)

Freemium

- Dotpict  
- ReSprite

Etc.

A huge advantage of dedicated pixel art editors that saves you the time and headache is exporting game-ready assets.

For today’s example we’ll be using the simplest one which is Piskel, you can use the online version here:  
[PISKEL KIDS](https://www.piskelapp.com/kids/)

Note that we use the “kids” version as it has all the features as the normal version but with no ads\!

---

## LEARNING ABOUT THE TOOL

Piskel is a completely free tool for creating pixel art that has just enough features for a beginner and suitable to just “trying out” pixel art before moving to more advanced software like Aseprite.

We’ll learn more about the tool as we go but there are some settings that I recommend you to apply first.

First, create a new sprite (Or resize your sprite) to become a 32x32 image.

Go to Settings\>misc and select the lightest background (left) and 1.00 layer opacity.  
This allows better visibility and doesn’t obscure the layer underneath when we add new layers.

<img src="images/image30.png" alt="Image 10" width="300">

Next, go to Settings\>Grid and enable it using these settings.  
Using a grid makes a difference when you’re doing detailed work\! You can adjust the grid spacing as well.

<img src="images/image5.png" alt="Image 11" width="300">

Now that our settings are set, your work environment should look like this.

<img src="images/image11.png" alt="Image 12" width="300">

### CREATING AND COLOURING A BASIC SHAPE (SIMPLE BALL)

Let’s walk through the tools with learning by doing. Let’s draw a very simple, shaded ball.

First, we want to make a circle using the circle tool (C) and holding shift to make a perfect circle.

<img src="images/image3.png" alt="Image 13" width="300">

<img src="images/image28.png" alt="Image 14" width="300">

It’s okay if the circle is not in the middle of the workspace, you can center it by clicking the auto align function in the transform menu on the right.

<img src="images/image8.png" alt="Image 15" width="300">

We now have a Line Art of a circle. 

Line art is the most basic form of pixel art, and everything later will come together with the shape of our line.

Now give the circle a basic colour.

Go to the primary colour selection and select any saturated colour (e.g. red, \#ff0000). (tip: go to the top right of the colour picker)

<img src="images/image1.png" alt="Image 16" width="300">

Colour the circle with the paint bucket tool.

<img src="images/image52.png" alt="Image 17" width="300">

We now have a red 2-dimensional circle.

The next part is rendering it to make it three dimensional.  
Let’s decide that a light source is coming from the top right of the image. Therefore the colour will gradually go from light to dark starting from the top right to the bottom left.

Click on the New Layer on the layers menu and name it shadows.  
<img src="images/image41.png" alt="Image 18" width="300">

Change the colour into a deeper shade of your saturated colour (tip: stick to the right of the colour picker).. 

<img src="images/image14.png" alt="Image 19" width="300">

Using the pen tool and eraser tool, work out the shadows of the ball by imagining a rounded shape.  
As we can see on the preview on the top right corner, it’s starting to have a 3d shape from afar.

<img src="images/image37.png" alt="Image 20" width="300">

Now add a new layer and call it light.

Similarly as we did previously, still imagining a rounded shape, we will now paint the top right of the circle with a lighter colour to simulate light striking the ball. Use a less saturated bright colour of your original shade (tip: go to the middle top).

<img src="images/image43.png" alt="Image 21" width="300">

<img src="images/image49.png" alt="Image 22" width="300">

Now we have a shaded ball with a soft light.

Add a white highlight if you wish\!

<img src="images/image33.png" alt="Image 23" width="300">

You can also colour in your lineart to sell the 3D immersion. Use a variety of saturated colours (the right edge of the colour picker) that’s darker than your base colour. Or just stick with black if you’re going for a cartoon black lines style. It’s up to your style\!

<img src="images/image44.png" alt="Image 24" width="300">

Save the work we did so far by clicking the save menu on the right edge of the screen.

<img src="images/image39.png" alt="Image 25" width="300">

## SIMPLE BOUNCE ANIMATION

Now we are going to simulate a bouncy ball using simple animations.

To simplify the next steps, go to the Layers menu and merge below all of our layers until we end up with one layer.

<img src="images/image17.png" alt="Image 26" width="300">  
<img src="images/image24.png" alt="Image 27" width="300">

Next, duplicate our first frame until we get 5 identical ones.

<img src="images/image10.png" alt="Image 28" width="300">

On the first frame, click the Move tool or press ‘M’ and move the ball down until it touches the bottom.  
On the second frame, move it to the center of the frame.  
On the third frame, move it to the top but leave a one pixel margin,  
On the fourth frame, move it to the center but push it up one pixel.  
On the fifth frame, move it just one pixel above the bottom of the frame.

<img src="images/image18.png" alt="Image 29" width="300">

The FPS slider on the right determines the speed of the frame by frame animation. Change it to a specific value e.g. 8 FPS.

Now go to the first frame, and pick the rectangle selection tool (S)

<img src="images/image22.png" alt="Image 30" width="300">

Select about the top half like this:

<img src="images/image50.png" alt="Image 31" width="300">

And while holding SHIFT, drag the selection down to squish the ball

<img src="images/image53.png" alt="Image 32" width="300">

And we’ll end up with an oval shape.

<img src="images/image29.png" alt="Image 33" width="300">

In the 2nd frame, we will take the left and right side of the ball and squish it inward horizontally.

<img src="images/image12.png" alt="Image 34" width="300">

Like so.

<img src="images/image25.png" alt="Image 35" width="300">

Continue Selecting and moving the parts of the ball until we get a smooth 5 frame animation of a bouncing ball with squash and stretch. 

Frame 2 should just be squished horizontally slightly  
Frame 3 should have a bigger squish  
Frame 4 should be the same as Frame 2  
Frame 5 should be our original unmodified ball.

<img src="images/image25.png" alt="Image 36" width="300">

We now have a complete sprite animation! Take a second to admire your work and don’t forget to save it.

<img src="images/BOUNCYBALL.gif" alt="gnome run animation" width="100">

Next, you can export this animation as a GIF Animation, or as a spritesheet to be used in Godot.

<img src="images/image31.png" alt="Image 37" width="300">

It really depends on how you want to export your sprite sheet as Godot (should) allows reading of sprite sheets in any row or column size. But let's keep it simple and export as a 5 column x 1 row sheet.

<img src="images/image42.png" alt="Image 38" width="300">

And this is what we ended up with. This bouncy ball can be used as a simple character with a Jump animation if you’d like\!

<img src="images/image47.png" alt="Image 39" width="300">

[FINISHED PROJECT](https://drive.google.com/drive/folders/17X89752JHAf_5Bcymg-6F6UZinc3xXyq?usp=sharing)

## CREATING A PLATFORMER CHARACTER

We now understand how to work with a 32 x 32 workspace, have our way around the tools, creating and exporting a simple animation. Now we’ll try to make a game ready platformer character.

To save time, we can modify an existing asset into our own. There are tons of free assets available, but we are especially interested in ones that state this:

“These assets are released under a Creative Commons Zero (CC0) license. You can distribute, remix, adapt, and build upon the material in any medium or format, even for commercial purposes. “

It is important to check with the author for their attribution and credit system. Gotta stay ethical\!

One such asset pack we can modify is this one:

[PIXEL ADVENTURE 1 (By Pixel Frog)](https://pixelfrog-assets.itch.io/pixel-adventure-1)

Which is perfect because the characters are 32x32, the same as our previous example!

You don't have to download it for this workshop but you can freely explore it for yourself. This workshop uses a modified file of one of the characters that can be found in the next section.

---

### Importing a sprite sheet

In an empty Piskel workspace, select import, and import from picture

<img src="images/image9.png" alt="Image 40" width="300">

<img src="images/image20.png" alt="Image 41" width="300">

Look for “Pink Man” inside the Main Characters folder in the Pixel Adventure 1 asset pack.  
Choose the Run (32x32) png file.

<img src="images/image38.png" alt="Image 42" width="300">

Now import this as a sprite sheet, change the frame size to 32 x 32\.

<img src="images/image51.png" alt="Image 43" width="300">

Now we’ve imported the character’s walk cycle as a sprite sheet\!

<img src="images/image4.png" alt="Image 44" width="300">

As we can see, the walk cycle is 12 Frames. To save time, we can strategically remove the in-between frames to end up with just a 5 frame walk cycle.

<img src="images/image48.png" alt="Image 45" width="300">

We can leave the following frames to make a sufficient walk cycle:  
2, 5, 8, 9, 10

<img src="images/image40.png" alt="Image 46" width="300">

[DOWNLOAD THE MODIFIED FILE HERE (RUN_5frames)](https://drive.google.com/drive/folders/17X89752JHAf_5Bcymg-6F6UZinc3xXyq?usp=sharing)

It’s not gonna be the smoothest walk cycle, but for the sake of simplicity of this workshop and your upcoming game jam, we can use it. Feel free to modify the original 12 frame animation if you want your stuff to look smooth!

---

### Modifying the sprite to animate your own character’s walk cycle

It really depends on what your character will be and the design of the character, but let’s say I want to make a woodland creature inspired by the Minish race from the Legend of Zelda.

<img src="images/image15.png" alt="Image 47" width="100"> 

I painted on top of the first frame first, preserving the original lineart and shape while adding my own elements.

<img src="images/image46.png" alt="Image 48" width="300">

With the rectangle tool selected, I can select over the whole area and press CTRL+C to copy

<img src="images/image26.png" alt="Image 49" width="300">

Move to Frame 2, create a New layer, and paste (CTRL+V) your character into the second frame.

<img src="images/image21.png" alt="Image 50" width="300">

Move the character in Frame 2 to the bottom, erase the arms and legs of the new character and erase the head of the old character.

We will paint new arms and legs to match up with the reference.

<img src="images/image2.png" alt="Image 51" width="300">

<img src="images/image36.png" alt="Image 52" width="300">

Do the same with frame 3, 4, and 5!   
Take your time in figuring out things, as this is where the real creative process happens. 🙂

<img src="images/image23.png" alt="Image 53" width="300">

We'll end up with a custom pixel art with animations ready to put in our game.

<img src="images/GnomeRun.gif" alt="gnome run animation" width="100">

Now export your newly crafted spritesheet and admire your work!

<img src="images/image32.png" alt="Image 54" width="300">

That wraps up this tutorial session, every .piskel and spritesheet file made is on this drive link:

[FINISHED PROJECT FILES](https://drive.google.com/drive/folders/17X89752JHAf_5Bcymg-6F6UZinc3xXyq)

---

Some cool resources if you want to get serious about pixel art:

What Size To Make Pixel Art: [https\://youtu.be/AXb-VBZTKDA?si=b4ybXTUWRriRHQt6](https://youtu.be/AXb-VBZTKDA?si=b4ybXTUWRriRHQt6) 

3 Pixel Art Technique / Common Mistakes: [https\://youtu.be/gW1G\_FLsuEs?si=RWdcRN88DvJRuUi0](https://youtu.be/gW1G_FLsuEs?si=RWdcRN88DvJRuUi0) 

Basic Anti-Aliasing for Beginner: [https\://youtu.be/UN-m3o9V7kk?si=Uxf84XxhoxBSwUSJ](https://youtu.be/UN-m3o9V7kk?si=Uxf84XxhoxBSwUSJ)

Get and study various games’ pixel art assets: 
[https\://www\.spriters-resource.com/](https://www.spriters-resource.com/)

